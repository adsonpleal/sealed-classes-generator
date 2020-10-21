import 'package:sealed_classes_generator/src/use_cases/build_generated_code_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_code_for_class_use_case.dart';

import '../sealed_class_generator.dart';
import '../use_cases/generate_class_declaration_use_case.dart';
import '../use_cases/generate_sealed_extension_use_case.dart';
import '../use_cases/generate_sealed_function_calls_use_case.dart';
import '../use_cases/generate_sealed_parameters_use_case.dart';
import '../use_cases/get_annotate_classes_use_case.dart';
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
  final generateCodeForClassUseCase = GenerateCodeForClassUseCase(generateSealedExtensionUseCase,);
  final buildGeneratedCodeUseCase = BuildGeneratedCodeUseCase(generateCodeForClassUseCase);

  return SealedClassGenerator(
    buildGeneratedCodeUseCase,
    getAnnotatedClassesUseCase,
  );
}
