import 'package:analyzer/dart/element/element.dart';

class GenerateParamDeclarationUseCase {
  String call(ParameterElement param) {
    return "final ${param.type.getDisplayString()} ${param.name};";
  }
}

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

class GenerateClassDeclarationUseCase {
  const GenerateClassDeclarationUseCase(
    this._generateParamsDeclarations,
    this._generateFullConstructorParams,
  );

  final GenerateParamsDeclarationsUseCase _generateParamsDeclarations;
  final GenerateFullConstructorParamsUseCase _generateFullConstructorParams;

  String call(ConstructorElement constructor, String parent) {
    final name = constructor.name;
    final isConst = constructor.isConst;
    final parameters = constructor.parameters;
    final paramsDeclarations = _generateParamsDeclarations(parameters);
    final fullConstructorParams = _generateFullConstructorParams(parameters);
    final paramsNames = parameters.map((param) => param.name);
    final propsParams = paramsNames.join(',');
    return """
      class _\$$name extends Equatable implements $parent {
        ${isConst ? 'const' : ''} _\$$name($fullConstructorParams);

        ${paramsDeclarations}

        @override
        List<Object> get props => [$propsParams];
      }
    """;
  }
}