import 'package:analyzer/dart/element/element.dart';











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

class GeneratePropsParamsUseCase {
  String call(List<ParameterElement> params) {
    return params.map((param) => param.name).join(',');
  }
}

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
