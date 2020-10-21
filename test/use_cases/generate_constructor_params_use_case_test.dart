import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_constructor_params_use_case.dart';

import '../mocks.dart';

void main() {
  test('should map and join positional parameters', () {
    final param1 = ParameterElementMock();
    final param2 = ParameterElementMock();
    final param3 = ParameterElementMock();
    final params = [param1, param2, param3];

    when(param1.isPositional).thenReturn(true);
    when(param2.isPositional).thenReturn(false);
    when(param3.isPositional).thenReturn(true);

    when(param1.name).thenReturn('param1');
    when(param3.name).thenReturn('param3');

    final useCase = GeneratePositionalConstructorParamsUseCase();

    final actual = useCase(params);

    expect(actual, 'this.param1,this.param3');
    verify(param1.isPositional).called(1);
    verify(param2.isPositional).called(1);
    verify(param3.isPositional).called(1);
    verify(param1.name).called(1);
    verify(param3.name).called(1);
    verifyNoMoreInteractions(param1);
    verifyNoMoreInteractions(param2);
    verifyNoMoreInteractions(param3);
  });
}
