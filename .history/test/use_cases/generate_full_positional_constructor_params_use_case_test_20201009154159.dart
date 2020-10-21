import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_constructor_params_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_named_constructor_params_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_positional_constructor_params_use_case.dart';

import '../mocks.dart';

void main() {
  GeneratePositionalConstructorParamsUseCase generatePositional;
  GenerateFullPositionalConstructorParamsUseCase useCase;

  setUp(() {
    generatePositional = GeneratePositionalConstructorParamsUseCaseMock();
    useCase =
        GenerateFullPositionalConstructorParamsUseCase(generatePositional,);
  });

  test('should return empty string for empty params', () {
    final params = <ParameterElement>[];
    when(generatePositional(params)).thenReturn('');

    final actual = useCase(params);

    expect(actual, '');
    verify(generatePositional(params)).called(1);
    verifyNoMoreInteractions(generatePositional);
  });

  test('should return string with params', () {
    final params = [
      ParameterElementMock(),
      ParameterElementMock(),
    ];
    final named = 'named';
    when(generatePositional(params)).thenReturn(named);

    final actual = useCase(params);

    expect(actual, "{$named,}");
    verify(generatePositional(params)).called(1);
    verifyNoMoreInteractions(generatePositional);
    for (final param in params) {
      verifyNoMoreInteractions(param);
    }
  });
}
