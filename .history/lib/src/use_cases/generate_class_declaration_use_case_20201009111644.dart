import 'package:analyzer/dart/element/element.dart';



GenerateParamsDeclarationsUseCase

class GenerateParamsDeclarationsUseCase {
  const GenerateParamsDeclarationsUseCase(this._generateParamDeclaration);

  final GenerateParamDeclarationUseCase _generateParamDeclaration;

  String call(List<ParameterElement> params) {
    return params.map(_generateParamDeclaration).join('\n');
  }
}

class GenerateConstructorParamsUseCase {
  const GenerateConstructorParamsUseCase(this.paramFinder);

  final bool Function(ParameterElement) paramFinder;

  String call(List<ParameterElement> params) {
    return params
        .where(paramFinder)
        .map((param) => "this.${param.name}")
        .join(',');
  }
}

class GeneratePositionalConstructorParamsUseCase
    extends GenerateConstructorParamsUseCase {
  GeneratePositionalConstructorParamsUseCase()
      : super((param) => param.isPositional);
}

class GenerateNamedConstructorParamsUseCase
    extends GenerateConstructorParamsUseCase {
  GenerateNamedConstructorParamsUseCase() : super((param) => param.isNamed);
}

class GenerateFullNamedConstructorParamsUseCase {
  GenerateFullNamedConstructorParamsUseCase(this._generateNamed);

  final GenerateNamedConstructorParamsUseCase _generateNamed;

  String call(List<ParameterElement> params) {
    final named = _generateNamed(params);
    return named.isNotEmpty ? "{$named,}" : '';
  }
}

class GenerateFullPositionalConstructorParamsUseCase {
  GenerateFullPositionalConstructorParamsUseCase(this._generatePositional);

  final GeneratePositionalConstructorParamsUseCase _generatePositional;

  String call(List<ParameterElement> params) {
    final positional = _generatePositional(params);
    return positional.isNotEmpty ? "$positional," : '';
  }
}

class GenerateFullConstructorParamsUseCase {
  const GenerateFullConstructorParamsUseCase(
    this._generateFullPositional,
    this._generateFullNamed,
  );

  final GenerateFullPositionalConstructorParamsUseCase _generateFullPositional;
  final GenerateFullNamedConstructorParamsUseCase _generateFullNamed;

  String call(List<ParameterElement> params) {
    final fullNamed = _generateFullNamed(params);
    final fullPositional = _generateFullPositional(params);
    return "$fullNamed $fullPositional";
  }
}

class GenerateConstDeclarationUseCase {
  String call(bool isConst) {
    return isConst ? 'const' : '';
  }
}

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
