import 'package:build/build.dart';
import "package:source_gen/source_gen.dart";

import 'use_cases/generate_class_declaration_use_case.dart';
import 'use_cases/generate_sealed_extension_use_case.dart';
import 'use_cases/get_annotate_classes_use_case.dart';

class SealedClassGenerator extends Generator {
  SealedClassGenerator(
    this._generateSealedExtension,
    this._generateDeclaration,
    this._getAnnotateClasses,
  );

  final GenerateSealedExtensionUseCase _generateSealedExtension;
  final GenerateClassDeclarationUseCase _generateDeclaration;
  final GetAnnotatedClassesUseCase _getAnnotateClasses;

  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final annotatedClasses = _getAnnotateClasses(library);

    if (annotatedClasses.isNotEmpty) {
      return annotatedClasses.map((annotatedClass) {
        final parent = annotatedClass.displayName;
        final constructors = annotatedClass.constructors;
        final declarations = constructors
            .map((constructor) => _generateDeclaration(constructor, parent))
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
