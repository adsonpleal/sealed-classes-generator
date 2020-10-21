import '../use_cases/generate_sealed_extension_use_case.dart';

import '../sealed_class_generator.dart';

SealedClassGenerator provideGenerator() {
  final constructorAsParameter = MapConstructorToSealedParameterUseCase();
  final generateSealedParameters = GenerateSealedParametersUseCase(
    constructorAsParameter,
  );
  final constructorAsFunctionCall = MapConstructorToSealedFunctionCallUseCase();
  final generateSealedFunctioCalls = GenerateSealedFunctionCallsUseCase(
    constructorAsFunctionCall,
  );

  final generateSealedExtensionUseCase = GenerateSealedExtensionUseCase(
    generateSealedParameters,
    generateSealedFunctioCalls,
  );

  return SealedClassGenerator(generateSealedExtensionUseCase);
}
