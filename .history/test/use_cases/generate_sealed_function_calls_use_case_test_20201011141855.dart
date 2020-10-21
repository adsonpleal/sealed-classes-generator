import 'package:flutter_test/flutter_test.dart';
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
    final constructors = [ConstructorElementMock(), ConstructorElementMock()];
    final hasDefault = true;

    final actual = useCase(constructors, hasDefault: hasDefault);
    
  });
}
