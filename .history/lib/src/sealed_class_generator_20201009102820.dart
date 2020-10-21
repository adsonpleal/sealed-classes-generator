import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import "package:source_gen/source_gen.dart";

import 'use_cases/generate_class_declaration_use_case.dart';
import 'use_cases/generate_sealed_extension_use_case.dart';
import 'use_cases/get_annotate_classes_use_case.dart';


GenerateClassesDeclarationsUseCase
class GenerateClassesDeclarationsUseCase {
  const GenerateClassesDeclarationsUseCase(this._generateDeclaration);

  final GenerateClassDeclarationUseCase _generateDeclaration;

  String call(List<ConstructorElement> constructors, String parent) {
    return constructors
        .map((constructor) => _generateDeclaration(constructor, parent))
        .join('\n');
  }
}

class SealedClassGenerator extends Generator {
  const SealedClassGenerator(
    this._generateSealedExtension,
    this._generateDeclarations,
    this._getAnnotateClasses,
  );

  final GenerateSealedExtensionUseCase _generateSealedExtension;
  final GenerateClassesDeclarationsUseCase _generateDeclarations;
  final GetAnnotatedClassesUseCase _getAnnotateClasses;

  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final annotatedClasses = _getAnnotateClasses(library);

    if (annotatedClasses.isNotEmpty) {
      return annotatedClasses.map((annotatedClass) {
        final parent = annotatedClass.displayName;
        final constructors = annotatedClass.constructors;
        final declarations = _generateDeclarations(constructors, parent);
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
