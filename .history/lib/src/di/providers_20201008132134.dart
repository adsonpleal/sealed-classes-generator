

import 'package:sealed_classes_generator/src/use_cases/generate_sealed_extension_use_case.dart';

GenerateSealedExtensionUseCase provideGenerateSealedExtensionUseCase() {
  final generateSealedParameters = GenerateSealedParametersUseCase();
  final GenerateSealedFunctionCallsUseCase generateSealedFunctioCalls;

return GenerateSealedExtensionUseCase(generateSealedParameters, generateSealedFunctioCalls);
}