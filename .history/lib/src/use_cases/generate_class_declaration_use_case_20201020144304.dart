import 'package:analyzer/dart/element/element.dart';

import 'generate_class_constructor_use_case.dart';
import 'generate_class_name_use_case.dart';
import 'generate_params_declarations_use_case.dart';
import 'generate_props_params_use_case.dart';

class GenerateClassDeclarationUseCase {
  const GenerateClassDeclarationUseCase(
    this._generateParamsDeclarations,
    this._generateClassConstructor,
    this._generatePropsParams,
    this._generateClassName,
  );

  final GenerateParamsDeclarationsUseCase _generateParamsDeclarations;
  final GenerateClassConstructorUseCase _generateClassConstructor;
  final GeneratePropsParamsUseCase _generatePropsParams;
  final GenerateClassNameUseCase _generateClassName;

  String call(ConstructorElement constructor, String parent) {
    final name = constructor.name;
    final parameters = constructor.parameters;
    final className = _generateClassName(name, parent);

    final paramsDeclarations = _generateParamsDeclarations(parameters);
    final constructorDeclaration = _generateClassConstructor(constructor);
    final propsParams = _generatePropsParams(parameters);
    return """
      class $className extends Equatable implements $parent {
        $constructorDeclaration

        $paramsDeclarations

        @override
        List<Object> get props => [$propsParams];
      }
    """;
  }
}
