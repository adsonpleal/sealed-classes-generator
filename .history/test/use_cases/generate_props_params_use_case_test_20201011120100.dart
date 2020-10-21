import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_props_params_use_case.dart';

import '../mocks.dart';

void main() {
  test('should map param name and join with comma', () {
    final name1 = 'name1';
    final name2 = 'name2';
    final param1 = ParameterElementMock();
    final param2 = ParameterElementMock();
    final params = [param1, param2];
    final useCase = GeneratePropsParamsUseCase();

    when(param1.name).thenReturn(name1);
    when(param2.name).thenReturn(name2);

    final actual = useCase(params);

    expect(actual, "$name1,$name2");
    verify(param1.name).called(1);
    verify(param2.name).called(1);
  });
}
