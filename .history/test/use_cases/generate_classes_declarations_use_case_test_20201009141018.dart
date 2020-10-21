import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_declaration_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_classes_declarations_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateClassDeclarationUseCase generateDeclaration;
  GenerateClassesDeclarationsUseCase useCase;

  setUp(() {
    generateDeclaration = GenerateClassDeclarationUseCaseMock();
    useCase = GenerateClassesDeclarationsUseCase(generateDeclaration);
  });

  test('should join gnerated declarations', () {
    final classElement = ClassElementMock();
    final constructor1 = ConstructorElementMock();
    final constructor2 = ConstructorElementMock();
    final constructors = [constructor1, constructor2];

    when(generateDeclaration(constructor1)).thenReturn('constructor1');
  });
}
