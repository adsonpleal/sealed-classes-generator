import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_parameters_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/map_constructor_to_sealed_parameter_use_case.dart';

import '../mocks.dart';

void main() {
  MapConstructorToSealedParameterUseCase constructorAsParameter;
  GenerateSealedParametersUseCase useCase;

  setUp(() {
    constructorAsParameter = MapConstructorToSealedParameterUseCaseMock();
    useCase = GenerateSealedParametersUseCase(constructorAsParameter);
  });

  test('should generate param with sufix', () {
    const hasDefault = true;
    const parameters1 = 'parameters1';
    const parameters2 = 'parameters2';
    final constructor1 = ConstructorElementMock();
    final constructor2 = ConstructorElementMock();
    final constructors = [constructor1, constructor2];

    when(constructorAsParameter(constructor1, !hasDefault))
        .thenReturn(parameters1);
    when(constructorAsParameter(constructor2, !hasDefault))
        .thenReturn(parameters2);

    final actual = useCase(constructors, hasDefault: hasDefault);

    expect(
      actual,
      "$parameters1,$parameters2, @required T Function() defaultAction,",
    );
    verify(constructorAsParameter(constructor1, !hasDefault)).called(1);
    verify(constructorAsParameter(constructor2, !hasDefault)).called(1);
    verifyNoMoreInteractions(constructorAsParameter);
    verifyNoMoreInteractions(constructor1);
    verifyNoMoreInteractions(constructor2);
  });
}
