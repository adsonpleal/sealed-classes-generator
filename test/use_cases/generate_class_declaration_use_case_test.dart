import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_constructor_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_declaration_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_name_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_params_declarations_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_props_params_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateParamsDeclarationsUseCase generateParamsDeclarations;
  GenerateClassConstructorUseCase generateClassConstructor;
  GeneratePropsParamsUseCase generatePropsParams;
  GenerateClassNameUseCase generateClassName;
  GenerateClassDeclarationUseCase useCase;

  setUp(() {
    generateParamsDeclarations = GenerateParamsDeclarationsUseCaseMock();
    generateClassConstructor = GenerateClassConstructorUseCaseMock();
    generatePropsParams = GeneratePropsParamsUseCaseMock();
    generateClassName = GenerateClassNameUseCaseMock();
    useCase = GenerateClassDeclarationUseCase(
      generateParamsDeclarations,
      generateClassConstructor,
      generatePropsParams,
      generateClassName,
    );
  });

  test('should generate class with right values', () {
    final parameters = [ParameterElementMock(), ParameterElementMock()];
    final constructor = ConstructorElementMock();
    final returnType = InterfaceTypeMock();
    final parent = "Parent";
    final paramsDeclarations = 'paramsDeclarations';
    final constructorDeclaration = 'constructorDeclaration';
    final propsParams = 'propsParams';
    final className = 'FakeClassName';

    when(constructor.parameters).thenReturn(parameters);
    when(generateParamsDeclarations(parameters)).thenReturn(paramsDeclarations);
    when(generateClassConstructor(constructor))
        .thenReturn(constructorDeclaration);
    when(generatePropsParams(parameters)).thenReturn(propsParams);
    when(generateClassName(constructor)).thenReturn(className);
    when(constructor.returnType).thenReturn(returnType);
    when(returnType.getDisplayString()).thenReturn(parent);

    final actual = useCase(constructor);

    expect(actual, """
      class $className extends Equatable implements $parent {
        $constructorDeclaration

        $paramsDeclarations

        @override
        List<Object> get props => [$propsParams];
      }
    """);
    verify(generateParamsDeclarations(parameters)).called(1);
    verify(generateClassConstructor(constructor)).called(1);
    verify(generatePropsParams(parameters)).called(1);
    verify(generateClassName(constructor)).called(1);
    verifyNoMoreInteractions(generateParamsDeclarations);
    verifyNoMoreInteractions(generateClassConstructor);
    verifyNoMoreInteractions(generatePropsParams);
    verifyNoMoreInteractions(generateClassName);
  });
}
