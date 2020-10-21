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

class GenerateFullConstructorParamsUseCase {
  const GenerateFullConstructorParamsUseCase(
    this._generatePositional,
    this._generateNamed,
  );

  final GeneratePositionalConstructorParamsUseCase
      _generatePositional;
  final GenerateNamedConstructorParamsUseCase _generateNamed;

  String call(List<ParameterElement> params) {
    final positionalConstructorParams = params
        .where((param) => param.isPositional)
        .map((param) => "this.${param.name}")
        .join(',');

    final namedConstructorParams = params
        .where((param) => param.isNamed)
        .map((param) => "this.${param.name}")
        .join(',');

    final fullNamedConstructorParams =
        namedConstructorParams.isNotEmpty ? "{${namedConstructorParams},}" : '';
    final fullPositionalConstructorParams =
        positionalConstructorParams.isNotEmpty
            ? "${positionalConstructorParams},"
            : '';
    return "$fullNamedConstructorParams $fullPositionalConstructorParams";
  }
}

class GenerateClassDeclarationUseCase {
  const GenerateClassDeclarationUseCase(this._generateParamsDeclarations);

  final GenerateParamsDeclarationsUseCase _generateParamsDeclarations;

  String call(ConstructorElement constructor, String parent) {
    final name = constructor.name;
    final isConst = constructor.isConst;
    final parameters = constructor.parameters;
    final paramsDeclarations = _generateParamsDeclarations(parameters);
    final paramsNames = parameters.map((param) => param.name);
    final propsParams = paramsNames.join(',');
    final positionalConstructorParams = parameters
        .where((param) => param.isPositional)
        .map((param) => "this.${param.name}")
        .join(',');

    final namedConstructorParams = parameters
        .where((param) => param.isNamed)
        .map((param) => "this.${param.name}")
        .join(',');

    final fullNamedConstructorParams =
        namedConstructorParams.isNotEmpty ? "{${namedConstructorParams},}" : '';
    final fullPositionalConstructorParams =
        positionalConstructorParams.isNotEmpty
            ? "${positionalConstructorParams},"
            : '';
    return """
      class _\$$name extends Equatable implements $parent {
        ${isConst ? 'const' : ''} _\$$name($fullPositionalConstructorParams$fullNamedConstructorParams);

        ${paramsDeclarations}

        @override
        List<Object> get props => [$propsParams];
      }
    """;
  }
}
