import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/map_constructor_to_sealed_function_call_use_case.dart';

import '../mocks.dart';

void main() {
  MapConstructorToSealedFunctionCallUseCase useCase;

  setUp(() {
    useCase = MapConstructorToSealedFunctionCallUseCase();
  });

  test('should check null and add argument', () {
    final constructor = ConstructorElementMock();
    final name = 'name';
    final params = [ParameterElementMock()];

    when(constructor.name).thenReturn(name);
    when(constructor.parameters).thenReturn(params);
  });
}
