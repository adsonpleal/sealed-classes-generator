import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class SealedClassGenerator extends Generator {
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

  String _generateSealedExtension(
    List<ConstructorElement> constructors,
    String parent,
  ) {
    final parameters = constructors
        .map((constructor) {
          final name = constructor.name;
          final functionParams = constructor.parameters.map((param) => "${param.type.getDisplayString()} ${param.name}").join(',');
          return "@required T Function() $name";
        });
    return """
     extension Sealed$parent on $parent {
      // ignore: missing_return
      T when<T>({
        @required T Function() loading,
        @required T Function(String message) finished,
        @required T Function() error,
      }) {
        if (this is _\$loading) {
          return loading();
        } else if (this is _\$finished) {
          return finished((this as _\$finished).message);
        } else if (this is _\$error) {
          return error();
        }
      }
    }
    """;
  }
}

extension on ConstructorElement {
  String asClassDeclaration(String parent) {
    final paramsDeclarations = parameters
        .map((param) => "final ${param.type.getDisplayString()} ${param.name};")
        .join('\n');
    final paramsNames = parameters.map((param) => param.name);
    final propsParams = paramsNames.join(',');
    final constructorParams =
        paramsNames.map((name) => "this.${name}").join(',');
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

// class _\$loading extends Equatable implements TestState {
//   const _\$loading();

//   @override
//   List<Object> get props => null;
// }

// class _\$finished extends Equatable implements TestState {
//   const _\$finished(this.message);

//   final String message;

//   @override
//   List<Object> get props => [message];
// }

// class _\$error extends Equatable implements TestState {
//   const _\$error();

//   @override
//   List<Object> get props => null;
// }

// extension SealedTestState on TestState {
//   // ignore: missing_return
//   T when<T>({
//     @required T Function() loading,
//     @required T Function(String message) finished,
//     @required T Function() error,
//   }) {
//     if (this is _\$loading) {
//       return loading();
//     } else if (this is _\$finished) {
//       return finished((this as _\$finished).message);
//     } else if (this is _\$error) {
//       return error();
//     }
//   }
// }
