import 'package:sealed_classes_generator/src/use_cases/get_annotate_classes_use_case.dart';

import '../sealed_class_generator.dart';
import '../use_cases/generate_class_declaration_use_case.dart';
import '../use_cases/generate_sealed_extension_use_case.dart';
import '../use_cases/generate_sealed_function_calls_use_case.dart';
import '../use_cases/generate_sealed_parameters_use_case.dart';
import '../use_cases/map_constructor_to_sealed_function_call_use_case.dart';
import '../use_cases/map_constructor_to_sealed_parameter_use_case.dart';

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

  final generateClassDeclarationUseCase = GenerateClassDeclarationUseCase();
  final getAnnotatedClassesUseCase = GetAnnotatedClassesUseCase();

  return SealedClassGenerator(
    generateSealedExtensionUseCase,
    generateClassDeclarationUseCase,
    getAnnotatedClassesUseCase,
  );
}
