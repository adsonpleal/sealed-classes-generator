import 'package:analyzer/dart/element/element.dart';

import 'generate_class_constructor_use_case.dart';
import 'generate_params_declarations_use_case.dart';
import 'generate_props_params_use_case.dart';

class GenerateClassDeclarationUseCase {
  const GenerateClassDeclarationUseCase(
    this._generateParamsDeclarations,
    this._generateClassConstructor,
    this._generatePropsParams,
  );

  final GenerateParamsDeclarationsUseCase _generateParamsDeclarations;
  final GenerateClassConstructorUseCase _generateClassConstructor;
  final GeneratePropsParamsUseCase _generatePropsParams;

  String call(ConstructorElement constructor, String parent) {
    final name = constructor.name;
    final parameters = constructor.parameters;

    final paramsDeclarations = _generateParamsDeclarations(parameters);
    final constructorDeclaration = _generateClassConstructor(constructor);
    final propsParams = _generatePropsParams(parameters);
    return """
      class _\$$name extends Equatable implements $parent {
        $constructorDeclaration

        $paramsDeclarations

        @override
        List<Object> get props => [$propsParams];
      }
    """;
  }
}