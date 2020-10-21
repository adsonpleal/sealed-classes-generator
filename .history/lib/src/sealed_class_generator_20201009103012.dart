import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import "package:source_gen/source_gen.dart";

import 'use_cases/generate_classes_declarations_use_case.dart';
import 'use_cases/generate_sealed_extension_use_case.dart';
import 'use_cases/get_annotate_classes_use_case.dart';

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
      return _generateCode(annotatedClasses);
    }
    return null;
  }

  String _generateCode(List<ClassElement> classes) {
    return classes.map((annotatedClass) {
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
}
