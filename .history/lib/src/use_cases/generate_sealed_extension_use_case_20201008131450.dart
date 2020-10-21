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
  GenerateSealedParametersUseCase(this._mapConstructorToSealedParameter);
final MapConstructorToSealedParameterUseCase _mapConstructorToSealedParameter;


  String call(List<ConstructorElement> constructors) =>
      constructors.map(_constructorAsParameter).join(',');
}

class GenerateSealedFunctionCallsUseCase {
  String call(List<ConstructorElement> constructors) {
    return constructors.map(_constructorAsFunctionCall).join(' else ');
  }

  String _constructorAsFunctionCall(ConstructorElement constructor) {
    final name = constructor.name;
    final arguments = constructor.parameters
        .map((param) => "(this as _\$$name).${param.name}")
        .join(',');
    return """
       if (this is _\$$name) {
          return $name($arguments);
        }
      """;
  }
}

class GenerateSealedExtensionUseCase {
  const GenerateSealedExtensionUseCase(this._generateSealedParameters);

  final GenerateSealedParametersUseCase _generateSealedParameters;

  String call(
    List<ConstructorElement> constructors,
    String parent,
  ) {
    final parameters = _generateSealedParameters(constructors);

    final functionCalls = constructors.map((constructor) {
      final name = constructor.name;
      final arguments = constructor.parameters
          .map((param) => "(this as _\$$name).${param.name}")
          .join(',');
      return """
       if (this is _\$$name) {
          return $name($arguments);
        }
      """;
    }).join(' else ');
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
