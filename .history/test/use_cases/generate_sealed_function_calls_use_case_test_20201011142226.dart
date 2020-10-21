import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_function_calls_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/map_constructor_to_sealed_function_call_use_case.dart';

import '../mocks.dart';

void main() {
  MapConstructorToSealedFunctionCallUseCase constructorAsFunctionCall;
  GenerateSealedFunctionCallsUseCase useCase;

  setUp(() {
    constructorAsFunctionCall = MapConstructorToSealedFunctionCallUseCaseMock();
    useCase = GenerateSealedFunctionCallsUseCase(constructorAsFunctionCall);
  });

  test('should generate function call with else branch', () {
    const functionCall1 = 'functionCall1';
    const functionCall2 = 'functionCall2';
    final constructor1 = ConstructorElementMock();
    final constructor2 = ConstructorElementMock();
    final constructors = [constructor1, constructor2];
    final hasDefault = true;

    when(constructorAsFunctionCall(constructor1, hasDefault))
        .thenReturn(functionCall1);
    when(constructorAsFunctionCall(constructor2, hasDefault))
        .thenReturn(functionCall2);

    final actual = useCase(constructors, hasDefault: hasDefault);

    expect(
      actual,
      "$functionCall1 else $functionCall2  else { return defaultAction(); }",
    );
    verify(constructorAsFunctionCall(constructor1, hasDefault)).called(1);
    verify(constructorAsFunctionCall(constructor2, hasDefault)).called(1);
    verifyNoMoreInteractions(constructorAsFunctionCall);
    verifyNoMoreInteractions(constructor1);
    verifyNoMoreInteractions(constructor2);
  });
}
