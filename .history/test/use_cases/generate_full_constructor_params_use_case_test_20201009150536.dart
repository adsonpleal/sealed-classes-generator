import 'package:flutter_test/flutter_test.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_constructor_params_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_named_constructor_params_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_positional_constructor_params_use_case.dart';

void main() {
  GenerateFullPositionalConstructorParamsUseCase generateFullPositional;
  GenerateFullNamedConstructorParamsUseCase generateFullNamed;
  GenerateFullConstructorParamsUseCase useCase;

  setUp(() {
    generateFullPositional =
        GenerateFullPositionalConstructorParamsUseCaseMock();
    generateFullNamed = GenerateFullNamedConstructorParamsUseCaseMock();
    useCase = GenerateFullConstructorParamsUseCase(
      generateFullPositional,
      generateFullNamed,
    );
  });
}
