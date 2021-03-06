import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_constructor_params_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_named_constructor_params_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_positional_constructor_params_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateFullPositionalConstructorParamsUseCase generateFullPositional;
  GenerateFullNamedConstructorParamsUseCase generateFullNamed;
  GenerateFullConstructorParamsUseCase useCase;

  setUp(() {
    generateFullPositional =
        GenerateFullPositionalConstructorParamsUseCaseMock();
    generateFullNamed = GenerateFullNamedConstructorParamsUseCaseMock();
    useCase = GenerateFullConstructorParamsUseCase(
      generateFullPositional,
      generateFullNamed,
    );
  });

  test('should generate full constructor params', () {
    final params = [ParameterElementMock(), ParameterElementMock()];
    const fullNamed = 'fullNamed';
    const fullPositional = 'fullPositional';

    when(generateFullNamed(params)).thenReturn(fullNamed);
    when(generateFullPositional(params)).thenReturn(fullPositional);

    final actual = useCase(params);
    expect(actual, "$fullPositional $fullNamed");
    verify(generateFullNamed(params)).called(1);
    verify(generateFullPositional(params)).called(1);
    for (final param in params) {
      verifyNoMoreInteractions(param);
    }
  });
}
