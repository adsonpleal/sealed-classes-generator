import 'package:flutter_test/flutter_test.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_classes_declarations_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_code_for_class_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_extension_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateSealedExtensionUseCase generateSealedExtension;
  GenerateClassesDeclarationsUseCase generateDeclarations;
  GenerateCodeForClassUseCase useCase;

  setUp(() {
    generateSealedExtension = GenerateSealedExtensionUseCaseMock();
    generateDeclarations = GenerateClassesDeclarationsUseCaseMock();

    useCase = GenerateCodeForClassUseCase(
      generateSealedExtension,
      generateDeclarations,
    );
  });

  test('should generate class with right values', () {
    const sealedExtension = 'sealedExtension';
    const declarations = 'declarations';

  

  });
}
