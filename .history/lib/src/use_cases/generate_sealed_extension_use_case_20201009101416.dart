import 'package:analyzer/dart/element/element.dart';





class MapConstructorToSealedFunctionCallUseCase {
  String call(ConstructorElement constructor, bool checkNull) {
    final name = constructor.name;
    final nullCheck = checkNull ? "&& $name != null" : '';
    final argument = constructor.hasParams ? "this as _\$$name" : '';
    return """
       if (this is _\$$name $nullCheck) {
          return $name($argument);
        }
      """;
  }
}

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
          ${_generateSealedParameters(constructors, hasDefault: true)}
        }) {
          ${_generateSealedFunctioCalls(constructors, hasDefault: true)}
        }
      }
    """;
  }
}

