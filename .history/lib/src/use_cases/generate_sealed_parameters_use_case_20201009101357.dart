import 'package:analyzer/dart/element/element.dart';

import 'map_constructor_to_sealed_parameter_use_case.dart';

class GenerateSealedParametersUseCase {
  const GenerateSealedParametersUseCase(this._constructorAsParameter);

  final MapConstructorToSealedParameterUseCase _constructorAsParameter;

  String call(
    List<ConstructorElement> constructors, {
    bool hasDefault = false,
  }) {
    final paramsSufix =
        hasDefault ? '@required T Function() defaultAction,' : '';
    final params = constructors
        .map((constructor) => _constructorAsParameter(constructor, !hasDefault))
        .join(',');
    return "$params, $paramsSufix";
  }
}
