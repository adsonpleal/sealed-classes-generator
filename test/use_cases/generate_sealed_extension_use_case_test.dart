import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_extension_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_function_calls_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_parameters_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateSealedParametersUseCase generateSealedParameters;
  GenerateSealedFunctionCallsUseCase generateSealedFunctioCalls;
  GenerateSealedExtensionUseCase useCase;

  setUp(() {
    generateSealedParameters = GenerateSealedParametersUseCaseMock();
    generateSealedFunctioCalls = GenerateSealedFunctionCallsUseCaseMock();
    useCase = GenerateSealedExtensionUseCase(
      generateSealedParameters,
      generateSealedFunctioCalls,
    );
  });

  test('should generate sealed extension with right params', () {
    final classElement = ClassElementMock();
    final className = 'className';
    final constructors = [ConstructorElementMock(), ConstructorElementMock()];
    final sealedParams = 'sealedParams';
    final sealedFunctionCalls = 'sealedFunctionCalls';
    final sealedParamsDefault = 'sealedParamsDefault';
    final sealedFunctionCallsDefault = 'sealedFunctionCallsDefault';

    when(classElement.name).thenReturn(className);
    when(classElement.constructors).thenReturn(constructors);
    when(generateSealedParameters(constructors)).thenReturn(sealedParams);
    when(generateSealedFunctioCalls(constructors))
        .thenReturn(sealedFunctionCalls);
    when(generateSealedParameters(
      constructors,
      hasDefault: true,
    )).thenReturn(sealedParamsDefault);
    when(generateSealedFunctioCalls(
      constructors,
      hasDefault: true,
    )).thenReturn(sealedFunctionCallsDefault);

    final actual = useCase(classElement);

    expect(actual, """
      extension Sealed$className on $className {
        // ignore: missing_return
        T when<T>({
          $sealedParams
        }) {
          $sealedFunctionCalls
        }

        T whenDefault<T>({
          $sealedParamsDefault
        }) {
          $sealedFunctionCallsDefault
        }
      }
    """);

    verify(classElement.name).called(1);
    verify(classElement.constructors).called(1);
    verify(generateSealedParameters(constructors)).called(1);
    verify(generateSealedFunctioCalls(constructors)).called(1);
    verify(generateSealedParameters(
      constructors,
      hasDefault: true,
    )).called(1);
    verify(generateSealedFunctioCalls(
      constructors,
      hasDefault: true,
    )).called(1);
    verifyNoMoreInteractions(classElement);
    verifyNoMoreInteractions(generateSealedParameters);
    verifyNoMoreInteractions(generateSealedFunctioCalls);
  });
}
