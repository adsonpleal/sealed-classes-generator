import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_constructor_params_use_case.dart';

import '../mocks.dart';

void main() {
  test('should map and join positional parameters', () {
    final param1 = ParameterElementMock();
    final param2 = ParameterElementMock();
    final param3 = ParameterElementMock();

    when()

    final useCase = GeneratePositionalConstructorParamsUseCase();
  });
}
