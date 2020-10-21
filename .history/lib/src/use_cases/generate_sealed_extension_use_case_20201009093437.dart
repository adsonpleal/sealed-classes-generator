import 'package:analyzer/dart/element/element.dart';

class MapConstructorToSealedParameterUseCase {
  String call(ConstructorElement constructor, bool isRequired) {
    final name = constructor.name;
    final functionParam = constructor.hasParams ? "_\$$name" : '';
    return "${isRequired ? '@required' : ''} T Function($functionParam) $name";
  }
}

class GenerateSealedParametersUseCase {
  const GenerateSealedParametersUseCase(this._constructorAsParameter);

  final MapConstructorToSealedParameterUseCase _constructorAsParameter;

  String call(
    List<ConstructorElement> constructors, {
    bool hasDefault = false,
  }) {
    final params = constructors
        .map((constructor) => _constructorAsParameter(constructor, !hasDefault))
        .join(',');
    return params.isNotEmpty ? "${params}," : '';
  }
}

class MapConstructorToSealedFunctionCallUseCase {
  String call(ConstructorElement constructor) {
    final name = constructor.name;
    final argument = constructor.hasParams ? "this as _\$$name" : '';
    return """
       if (this is _\$$name) {
          return $name($argument);
        }
      """;
  }
}

class GenerateSealedFunctionCallsUseCase {
  const GenerateSealedFunctionCallsUseCase(this._constructorAsFunctionCall);

  final MapConstructorToSealedFunctionCallUseCase _constructorAsFunctionCall;

  String call(List<ConstructorElement> constructors) =>
      constructors.map(_constructorAsFunctionCall).join(' else ');
}

class GenerateSealedExtensionUseCase {
  const GenerateSealedExtensionUseCase(
    this._generateSealedParameters,
    this._generateSealedFunctioCalls,
  );

  final GenerateSealedParametersUseCase _generateSealedParameters;
  final GenerateSealedFunctionCallsUseCase _generateSealedFunctioCalls;

  String call(
    List<ConstructorElement> constructors,
    String parent,
  ) {
    return """
      extension Sealed$parent on $parent {
        // ignore: missing_return
        T when<T>({
          ${_generateSealedParameters(constructors)}
        }) {
          ${_generateSealedFunctioCalls(constructors)}
        }

        T whenDefault<T>({
          ${_generateSealedParameters(constructors)}
        }) {
          ${_generateSealedFunctioCalls(constructors)}
        }
      }
    """;
  }
}

extension on ConstructorElement {
  bool get hasParams => parameters.isNotEmpty;
}
