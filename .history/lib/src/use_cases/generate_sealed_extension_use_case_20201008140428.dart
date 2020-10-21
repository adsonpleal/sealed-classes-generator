import 'package:analyzer/dart/element/element.dart';

class MapConstructorToSealedParameterUseCase {
  String call(ConstructorElement constructor) {
    final hasParams = constructor.parameters.isNotEmpty;
    final name = constructor.name;
    final functionParam = hasParams ? "_\$$name" : '';
    return "@required T Function($functionParam) $name";
  }
}

class GenerateSealedParametersUseCase {
  const GenerateSealedParametersUseCase(this._constructorAsParameter);

  final MapConstructorToSealedParameterUseCase _constructorAsParameter;

  String call(List<ConstructorElement> constructors) =>
      constructors.map(_constructorAsParameter).join(',');
}

class MapConstructorToSealedFunctionCallUseCase {
  String call(ConstructorElement constructor) {
    final name = constructor.name;
    final hasParams = constructor.parameters.isNotEmpty;
    final argument = hasParams ? "this as _\$$name" : '';
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

extension on ConstructorElement {
  
}