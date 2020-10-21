import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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
    final classElement = ClassElementMock();
    const extensionDeclaration = 'extensionDeclaration';
    const declarations = 'declarations';

    when(generateSealedExtension(classElement))
        .thenReturn(extensionDeclaration);
    when(generateDeclarations(classElement)).thenReturn(declarations);

    final actual = useCase(classElement);

    expect(actual, "$declarations\n$extensionDeclaration");
    verify(generateSealedExtension(classElement)).called(1);
    verify(generateDeclarations(classElement)).called(1);
    verifyNoMoreInteractions(classElement);
    verifyNoMoreInteractions(generateSealedExtension);
    verifyNoMoreInteractions(generateDeclarations);
  });
}
