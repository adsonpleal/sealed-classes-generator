import 'package:analyzer/dart/element/element.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_name_use_case.dart';

import 'generate_const_declaration_use_case.dart';
import 'generate_full_constructor_params_use_case.dart';

class GenerateClassConstructorUseCase {
  const GenerateClassConstructorUseCase(
    this._generateFullConstructorParams,
    this._generateConstDeclaration,
    this._generateClassName,
  );

  final GenerateFullConstructorParamsUseCase _generateFullConstructorParams;
  final GenerateConstDeclarationUseCase _generateConstDeclaration;
  final GenerateClassNameUseCase _generateClassName;

  String call(ConstructorElement constructor) {
    final className = _generateClassName(constructor);
    final parameters = constructor.parameters;
    final fullConstructorParams = _generateFullConstructorParams(parameters);
    final constDeclaration = _generateConstDeclaration(constructor.isConst);
    return "$constDeclaration $className._($fullConstructorParams);";
  }
}
