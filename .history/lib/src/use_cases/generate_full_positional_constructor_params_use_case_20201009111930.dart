import 'package:analyzer/dart/element/element.dart';

import 'generate_constructor_params_use_case.dart';

class GenerateFullPositionalConstructorParamsUseCase {
  GenerateFullPositionalConstructorParamsUseCase(this._generatePositional);

  final GeneratePositionalConstructorParamsUseCase _generatePositional;

  String call(List<ParameterElement> params) {
    final positional = _generatePositional(params);
    return positional.isNotEmpty ? "$positional," : '';
  }
}
