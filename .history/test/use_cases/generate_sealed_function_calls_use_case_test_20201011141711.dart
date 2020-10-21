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
}