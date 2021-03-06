import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_constructor_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_name_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_const_declaration_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_constructor_params_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateFullConstructorParamsUseCase generateFullConstructorParams;
  GenerateConstDeclarationUseCase generateConstDeclaration;
  GenerateClassNameUseCase generateClassName;
  GenerateClassConstructorUseCase useCase;

  setUp(() {
    generateFullConstructorParams = GenerateFullConstructorParamsUseCaseMock();
    generateConstDeclaration = GenerateConstDeclarationUseCaseMock();
    generateClassName = GenerateClassNameUseCaseMock();
    useCase = GenerateClassConstructorUseCase(
      generateFullConstructorParams,
      generateConstDeclaration,
      generateClassName,
    );
  });

  test('should generate class with right values', () {
    final constructor = ConstructorElementMock();
    final parameters = [ParameterElementMock()];
    const isConst = true;
    const fullConstructorParams = 'fullConstructorParams';
    const constDeclaration = 'const';
    const className = 'FakeClassName';

    when(constructor.isConst).thenReturn(isConst);
    when(constructor.parameters).thenReturn(parameters);
    when(generateFullConstructorParams(parameters))
        .thenReturn(fullConstructorParams);
    when(generateConstDeclaration(isConst)).thenReturn(constDeclaration);
    when(generateClassName(constructor)).thenReturn(className);

    final actual = useCase(constructor);

    expect(actual, "$constDeclaration $className._($fullConstructorParams);");
    verify(generateFullConstructorParams(parameters)).called(1);
    verify(generateClassName(constructor)).called(1);
    verify(generateConstDeclaration(isConst)).called(1);
    verifyNoMoreInteractions(generateConstDeclaration);
    verifyNoMoreInteractions(generateFullConstructorParams);
    verifyNoMoreInteractions(generateClassName);
  });
}
