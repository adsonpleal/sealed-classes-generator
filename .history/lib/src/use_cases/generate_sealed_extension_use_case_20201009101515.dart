import 'package:analyzer/dart/element/element.dart';

import 'generate_sealed_function_calls_use_case.dart';
import 'generate_sealed_parameters_use_case.dart';

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
