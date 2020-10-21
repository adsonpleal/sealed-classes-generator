[import 'package:analyzer/dart/element/element.dart';

import 'generate_const_declaration_use_case.dart';
import 'generate_full_constructor_params_use_case.dart';

class GenerateClassConstructorUseCase {
  const GenerateClassConstructorUseCase(
    this._generateFullConstructorParams,
    this._generateConstDeclaration,
  );

  final GenerateFullConstructorParamsUseCase _generateFullConstructorParams;
  final GenerateConstDeclarationUseCase _generateConstDeclaration;

  String call(ConstructorElement constructor) {
    final name = constructor.name;
    final parameters = constructor.parameters;
    final fullConstructorParams = _generateFullConstructorParams(parameters);
    final constDeclaration = _generateConstDeclaration(constructor.isConst);
    return "$constDeclaration _\$$name($fullConstructorParams);";
  }
}
