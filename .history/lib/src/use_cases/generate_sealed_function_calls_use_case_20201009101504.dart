import 'package:analyzer/dart/element/element.dart';

import 'map_constructor_to_sealed_function_call_use_case.dart';

class GenerateSealedFunctionCallsUseCase {
  const GenerateSealedFunctionCallsUseCase(this._constructorAsFunctionCall);

  final MapConstructorToSealedFunctionCallUseCase _constructorAsFunctionCall;

  String call(
    List<ConstructorElement> constructors, {
    bool hasDefault = false,
  }) {
    final sufix = hasDefault ? " else { return defaultAction(); }" : '';
    final ifChain = constructors
        .map((constructor) => _constructorAsFunctionCall(
              constructor,
              hasDefault,
            ))
        .join(' else ');
    return "$ifChain $sufix";
  }
}
