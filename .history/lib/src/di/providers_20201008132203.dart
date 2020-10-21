

import 'package:sealed_classes_generator/src/use_cases/generate_sealed_extension_use_case.dart';

GenerateSealedExtensionUseCase provideGenerateSealedExtensionUseCase() {
  final  constructorAsParameter = MapConstructorToSealedParameterUseCase();
  final generateSealedParameters = GenerateSealedParametersUseCase(constructorAsParameter);
  final generateSealedFunctioCalls = GenerateSealedFunctionCallsUseCase();

return GenerateSealedExtensionUseCase(generateSealedParameters, generateSealedFunctioCalls);
}