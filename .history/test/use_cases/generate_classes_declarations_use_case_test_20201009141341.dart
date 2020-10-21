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
    final className = 'ClassName';
    final classElement = ClassElementMock();
    final constructor1 = ConstructorElementMock();
    final constructor2 = ConstructorElementMock();
    final constructors = [constructor1, constructor2];

    when(classElement.constructors).thenReturn(constructors);
    when(classElement.name).thenReturn(className);
    when(generateDeclaration(constructor1, className))
        .thenReturn('constructor1');
    when(generateDeclaration(constructor2, className))
        .thenReturn('constructor2');

    final actual = useCase(classElement);

    expect(actual, "constructor1\nconstructor2");
    verify(generateDeclaration(constructor1, className)).called(1);
    verify(generateDeclaration(constructor2, className)).called(1);
    verifyNoMoreInteractions(generateDeclaration);
  });
}
