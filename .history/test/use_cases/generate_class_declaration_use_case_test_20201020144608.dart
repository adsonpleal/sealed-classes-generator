import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_constructor_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_declaration_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_params_declarations_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_props_params_use_case.dart';
import 'package:sealed_classes_generator/src/extensions/string_extension.dart';

import '../mocks.dart';

void main() {
  GenerateParamsDeclarationsUseCase generateParamsDeclarations;
  GenerateClassConstructorUseCase generateClassConstructor;
  GeneratePropsParamsUseCase generatePropsParams;
  GenerateClassDeclarationUseCase useCase;

  setUp(() {
    generateParamsDeclarations = GenerateParamsDeclarationsUseCaseMock();
    generateClassConstructor = GenerateClassConstructorUseCaseMock();
    generatePropsParams = GeneratePropsParamsUseCaseMock();
    useCase = GenerateClassDeclarationUseCase(
      generateParamsDeclarations,
      generateClassConstructor,
      generatePropsParams,
    );
  });

  test('should generate class with right values', () {
    final name = "fakeName";
    final parameters = [ParameterElementMock(), ParameterElementMock()];
    final constructor = ConstructorElementMock();
    final parent = "Parent";
    final paramsDeclarations = 'paramsDeclarations';
    final constructorDeclaration = 'constructorDeclaration';
    final propsParams = 'propsParams';
    final className = '$parent${name.capitalize()}';

    when(constructor.name).thenReturn(name);
    when(constructor.parameters).thenReturn(parameters);
    when(generateParamsDeclarations(parameters)).thenReturn(paramsDeclarations);
    when(generateClassConstructor(constructor, className))
        .thenReturn(constructorDeclaration);
    when(generatePropsParams(parameters)).thenReturn(propsParams);

    final actual = useCase(constructor, parent);

    expect(actual, """
      class $className extends Equatable implements $parent {
        $constructorDeclaration

        $paramsDeclarations

        @override
        List<Object> get props => [$propsParams];
      }
    """);
    verify(generateParamsDeclarations(parameters)).called(1);
    verify(generateClassConstructor(constructor, className)).called(1);
    verify(generatePropsParams(parameters)).called(1);
    verifyNoMoreInteractions(generateParamsDeclarations);
    verifyNoMoreInteractions(generateClassConstructor);
    verifyNoMoreInteractions(generatePropsParams);
  });
}
