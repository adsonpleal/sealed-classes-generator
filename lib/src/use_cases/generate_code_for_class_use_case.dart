import 'package:analyzer/dart/element/element.dart';

import 'generate_classes_declarations_use_case.dart';
import 'generate_sealed_extension_use_case.dart';

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
    return "$declarations\n$extensionDeclaration";
  }
}
