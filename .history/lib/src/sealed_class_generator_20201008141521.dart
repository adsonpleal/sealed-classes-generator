import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_extension_use_case.dart';
import 'package:source_gen/source_gen.dart';

class SealedClassGenerator extends Generator {
  SealedClassGenerator(this._generateSealedExtension);

  final GenerateSealedExtensionUseCase _generateSealedExtension;

  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final annotatedClasses = library.annotatedClasses;

    if (annotatedClasses.isNotEmpty) {
      return annotatedClasses.map((annotatedClass) {
        final parent = annotatedClass.displayName;
        final constructors = annotatedClass.constructors;
        final declarations = constructors
            .map((constructor) => constructor.asClassDeclaration(parent))
            .join('\n');
        final extensionDeclaration = _generateSealedExtension(
          constructors,
          parent,
        );
        return """
                ${declarations}
                ${extensionDeclaration}
            """;
      }).join('\n');
    }
    return null;
  }
}

extension on ConstructorElement {
  String asClassDeclaration(String parent) {
    final paramsDeclarations = parameters
        .where((param) => param.isPositional)
        .map((param) => "final ${param.type.getDisplayString()} ${param.name};")
        .join('\n');
    final paramsNames = parameters.map((param) => param.name);
    final propsParams = paramsNames.join(',');
    final constructorParams =
        parameters.map((param) => param.name).map((name) => "this.${name}").join(',');
    return """
      class _\$${name} extends Equatable implements ${parent} {
        ${isConst ? 'const' : ''} _\$${name}(${constructorParams});

        ${paramsDeclarations}

        @override
        List<Object> get props => [${propsParams}];
      }
    """;
  }
}

extension on LibraryReader {
  Iterable<ClassElement> get annotatedClasses =>
      allElements.whereType<ClassElement>().where((e) => e.hasSealed);
}
