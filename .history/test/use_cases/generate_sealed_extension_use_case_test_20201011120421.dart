import 'package:flutter_test/flutter_test.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_extension_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_function_calls_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_parameters_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateSealedParametersUseCase generateSealedParameters;
  GenerateSealedFunctionCallsUseCase generateSealedFunctioCalls;
  GenerateSealedExtensionUseCase useCase;

  setUp(() {
    generateSealedParameters = GenerateSealedParametersUseCaseMock();
    generateSealedFunctioCalls = GenerateSealedFunctionCallsUseCaseMock();
    useCase = GenerateSealedExtensionUseCase(
      generateSealedParameters,
      generateSealedFunctioCalls,
    );
  });
}
