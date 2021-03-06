import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_name_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/map_constructor_to_sealed_parameter_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateClassNameUseCase generateClassName;
  MapConstructorToSealedParameterUseCase useCase;

  setUp(() {
    generateClassName = GenerateClassNameUseCaseMock();
    useCase = MapConstructorToSealedParameterUseCase(generateClassName);
  });

  test('should generate parameter with required and with param', () {
    const isRequired = true;
    const name = 'name';
    const className = 'className';
    final params = [ParameterElementMock()];
    final constructor = ConstructorElementMock();

    when(constructor.parameters).thenReturn(params);
    when(constructor.name).thenReturn(name);
    when(generateClassName(constructor)).thenReturn(className);

    final actual = useCase(constructor, isRequired);

    expect(actual, "@required T Function($className) $name");
    verify(constructor.parameters).called(1);
    verify(constructor.name).called(1);
    verify(generateClassName(constructor)).called(1);
    verifyNoMoreInteractions(generateClassName);
    verifyNoMoreInteractions(constructor);
  });

  test('should generate parameter without required and with param', () {
    const isRequired = false;
    const name = 'name';
    const className = 'className';
    final params = [ParameterElementMock()];
    final constructor = ConstructorElementMock();

    when(constructor.parameters).thenReturn(params);
    when(constructor.name).thenReturn(name);
    when(generateClassName(constructor)).thenReturn(className);

    final actual = useCase(constructor, isRequired);

    expect(actual, "T Function($className) $name");
    verify(constructor.parameters).called(1);
    verify(constructor.name).called(1);
    verify(generateClassName(constructor)).called(1);
    verifyNoMoreInteractions(generateClassName);
    verifyNoMoreInteractions(constructor);
  });

  test('should generate parameter without required and without param', () {
    const isRequired = false;
    const name = 'name';
    final params = <ParameterElement>[];
    final constructor = ConstructorElementMock();

    when(constructor.parameters).thenReturn(params);
    when(constructor.name).thenReturn(name);

    final actual = useCase(constructor, isRequired);

    expect(actual, "T Function() $name");
    verify(constructor.parameters).called(1);
    verify(constructor.name).called(1);
    verifyNoMoreInteractions(constructor);
  });

  test('should generate parameter with required and without param', () {
    const isRequired = true;
    const name = 'name';
    final params = <ParameterElement>[];
    final constructor = ConstructorElementMock();

    when(constructor.parameters).thenReturn(params);
    when(constructor.name).thenReturn(name);

    final actual = useCase(constructor, isRequired);

    expect(actual, "@required T Function() $name");
    verify(constructor.parameters).called(1);
    verify(constructor.name).called(1);
    verifyNoMoreInteractions(constructor);
  });
}
