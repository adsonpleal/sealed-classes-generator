import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_constructor_params_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_named_constructor_params_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateNamedConstructorParamsUseCase generateNamed;
  GenerateFullNamedConstructorParamsUseCase useCase;

  setUp(() {
    generateNamed = GenerateNamedConstructorParamsUseCaseMock();
    useCase = GenerateFullNamedConstructorParamsUseCase(generateNamed);
  });

  test('should return empty string for empty params', () {
    final params = [];
    when(generateNamed(params)).thenReturn('');

    final actual = useCase(params);
    
    expect(actual, '');
    verify(generateNamed(params)).called(1);
    verifyNoMoreInteractions(generateNamed);
  });
}
