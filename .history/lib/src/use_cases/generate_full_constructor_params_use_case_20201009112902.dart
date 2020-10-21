import 'package:analyzer/dart/element/element.dart';

import 'generate_full_named_constructor_params_use_case.dart';
import 'generate_full_positional_constructor_params_use_case.dart';

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
    return "$fullPositional $fullNamed";
  }
}
