import 'package:analyzer/dart/element/element.dart';

import 'generate_constructor_params_use_case.dart';

class GenerateFullNamedConstructorParamsUseCase {
  GenerateFullNamedConstructorParamsUseCase(this._generateNamed);

  final GenerateNamedConstructorParamsUseCase _generateNamed;

  String call(List<ParameterElement> params) {
    final named = _generateNamed(params);
    return named.isNotEmpty ? "{$named,}" : '';
  }
}
