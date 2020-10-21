import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_constructor_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_const_declaration_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_constructor_params_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateFullConstructorParamsUseCase generateFullConstructorParams;
  GenerateConstDeclarationUseCase generateConstDeclaration;
  GenerateClassConstructorUseCase useCase;

  setUp(() {
    generateFullConstructorParams = GenerateFullConstructorParamsUseCaseMock();
    generateConstDeclaration = GenerateConstDeclarationUseCaseMock();
    useCase = GenerateClassConstructorUseCase(
      generateFullConstructorParams,
      generateConstDeclaration,
    );
  });

  test('should generate class with right values', () {
    final constructor = ConstructorElementMock();
    final parameters = [ParameterElementMock()];
    final name = 'fakeName';
    final isConst = true;
    final fullConstructorParams = 'fullConstructorParams';
    final constDeclaration = 'const';

    when(constructor.name).thenReturn(name);
    when(constructor.isConst).thenReturn(isConst);
    when(constructor.parameters).thenReturn(parameters);

    when(generateFullConstructorParams(parameters))
        .thenReturn(fullConstructorParams);
    when(generateConstDeclaration(isConst)).thenReturn(constDeclaration);

    final actual = useCase(constructor);
    expect(actual, "$constDeclaration _\$$name($fullConstructorParams);");
  });
}
