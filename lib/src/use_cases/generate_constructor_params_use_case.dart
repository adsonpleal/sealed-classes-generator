import 'package:analyzer/dart/element/element.dart';

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
