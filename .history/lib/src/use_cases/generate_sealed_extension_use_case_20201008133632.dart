import 'package:analyzer/dart/element/element.dart';

class MapConstructorToSealedParameterUseCase {
  String call(ConstructorElement constructor) {
    final name = constructor.name;
    final functionParams = constructor.parameters
        .map((param) => "${param.type.getDisplayString()}")
        .join(',');
    return "@required T Function($functionParams) $name";
  }
}

class GenerateSealedParametersUseCase {
  GenerateSealedParametersUseCase(this._constructorAsParameter);

  final MapConstructorToSealedParameterUseCase _constructorAsParameter;

  String call(List<ConstructorElement> constructors) =>
      constructors.map(_constructorAsParameter).join(',');
}

class MapConstructorToSealedFunctionCallUseCase {
  String call(ConstructorElement constructor) {
    final name = constructor.name;
    final arguments = constructor.parameters
        .map((param) => "${name}Cast.${param.name}")
        .join(',');
    var cast;
    if (arguments.isEmpty) {
      cast = '';
    } else {
      cast = "final ${name}Cast = $name as _\$$name;";
    }
    return """
       if (this is _\$$name) {
          $cast
          return $name($arguments);
        }
      """;
  }
}

class GenerateSealedFunctionCallsUseCase {
  GenerateSealedFunctionCallsUseCase(this._constructorAsFunctionCall);

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
    final parameters = _generateSealedParameters(constructors);
    final functionCalls = _generateSealedFunctioCalls(constructors);
    return """
      extension Sealed$parent on $parent {
        // ignore: missing_return
        T when<T>({
        $parameters
        }) {
          $functionCalls
        }
      }
    """;
  }
}
