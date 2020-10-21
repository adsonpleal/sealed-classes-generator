import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/map_constructor_to_sealed_parameter_use_case.dart';

import '../mocks.dart';

void main() {
  MapConstructorToSealedParameterUseCase useCase;

  setUp(() {
    useCase = MapConstructorToSealedParameterUseCase();
  });

  test('should generate parameter with required and with param', () {
    const isRequired = true;
    const name = 'name';
    final params = [ParameterElementMock()];
    final constructor = ConstructorElementMock();

    when(constructor.parameters).thenReturn(params);
    when(constructor.name).thenReturn(name);

    final actual = useCase(constructor, isRequired);

    expect(actual, "@required T Function(_\$$name) $name");
    verify(constructor.parameters).called(1);
    verify(constructor.name).called(1);
    verifyNoMoreInteractions(constructor);
  });
}
