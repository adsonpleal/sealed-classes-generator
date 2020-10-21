import 'package:flutter_test/flutter_test.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_constructor_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_declaration_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_params_declarations_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_props_params_use_case.dart';

void main() {
  GenerateParamsDeclarationsUseCase generateParamsDeclarations;
  GenerateClassConstructorUseCase generateClassConstructor;
  GeneratePropsParamsUseCase generatePropsParams;
  GenerateClassDeclarationUseCase useCase;

  setUp(() {
    generateParamsDeclarations =GenerateParamsDeclarationsUseCaseMock();
generateClassConstructor =GenerateClassConstructorUseCaseMock();
generatePropsParams =GeneratePropsParamsUseCaseMock();
useCase =GenerateClassDeclarationUseCase(
  generateParamsDeclarations,
generateClassConstructor,
generatePropsParams,
);
  })
}
