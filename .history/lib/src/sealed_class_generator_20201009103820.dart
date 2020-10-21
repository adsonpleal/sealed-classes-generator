import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import "package:source_gen/source_gen.dart";

import 'use_cases/generate_classes_declarations_use_case.dart';
import 'use_cases/generate_sealed_extension_use_case.dart';
import 'use_cases/get_annotate_classes_use_case.dart';

class GenerateCodeForClassUseCase {
  const GenerateCodeForClassUseCase(
    this._generateSealedExtension,
    this._generateDeclarations,
  );

  final GenerateSealedExtensionUseCase _generateSealedExtension;
  final GenerateClassesDeclarationsUseCase _generateDeclarations;

  String call(ClassElement classElement) {
    final declarations = _generateDeclarations(classElement);
    final extensionDeclaration = _generateSealedExtension(classElement);
    return """
                ${declarations}
                ${extensionDeclaration}
            """;
  }
}

class BuildGeneratedCodeUseCase {
  const BuildGeneratedCodeUseCase(this._generateCode);

  final GenerateCodeForClassUseCase _generateCode;

  String call(List<ClassElement> classes) {
    return classes.map(_generateCode).join('\n');
  }
}

class SealedClassGenerator extends Generator {
  const SealedClassGenerator(
    this._buildGeneratedCode,
    this._getAnnotateClasses,
  );

  final BuildGeneratedCodeUseCase _buildGeneratedCode;
  final GetAnnotatedClassesUseCase _getAnnotateClasses;

  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final annotatedClasses = _getAnnotateClasses(library);

    if (annotatedClasses.isNotEmpty) {
      return _buildGeneratedCode(annotatedClasses);
    }
    return null;
  }
}
