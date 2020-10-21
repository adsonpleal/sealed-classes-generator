import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_name_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/map_constructor_to_sealed_function_call_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateClassNameUseCase generateClassName;
  MapConstructorToSealedFunctionCallUseCase useCase;

  setUp(() {
    generateClassName = GenerateClassNameUseCaseMock();
    useCase = MapConstructorToSealedFunctionCallUseCase(generateClassName);
  });

  test('should check null and add argument', () {
    const checkNull = true;
    final constructor = ConstructorElementMock();
    final name = 'name';
    final className = 'ClassName';
    final params = [ParameterElementMock()];

    when(generateClassName(constructor)).thenReturn(className);
    when(constructor.name).thenReturn(name);
    when(constructor.parameters).thenReturn(params);

    final actual = useCase(constructor, checkNull);

    expect(actual, """
       if (this is $className && $name != null) {
          return $name(this as $className);
        }
      """);
    verify(constructor.name).called(1);
    verify(constructor.parameters).called(1);
    verify(generateClassName(constructor)).called(1);
    verifyNoMoreInteractions(generateClassName);
    verifyNoMoreInteractions(constructor);
  });

  test('should not check null and add argument', () {
    const checkNull = false;
    final constructor = ConstructorElementMock();
    final name = 'name';
    final params = [ParameterElementMock()];
    final className = 'ClassName';

    when(generateClassName(constructor)).thenReturn(className);
    when(constructor.name).thenReturn(name);
    when(constructor.parameters).thenReturn(params);

    final actual = useCase(constructor, checkNull);

    expect(actual, """
       if (this is $className) {
          return $name(this as $className);
        }
      """);
    verify(constructor.name).called(1);
    verify(constructor.parameters).called(1);
    verify(generateClassName(constructor)).called(1);
    verifyNoMoreInteractions(generateClassName);
    verifyNoMoreInteractions(constructor);
  });

  test('should not check null and don\'t add argument', () {
    const checkNull = false;
    final constructor = ConstructorElementMock();
    final name = 'name';
    final params = <ParameterElement>[];
    final className = 'ClassName';

    when(generateClassName(constructor)).thenReturn(className);
    when(constructor.name).thenReturn(name);
    when(constructor.parameters).thenReturn(params);

    final actual = useCase(constructor, checkNull);

    expect(actual, """
       if (this is $className) {
          return $name();
        }
      """);
    verify(constructor.name).called(1);
    verify(constructor.parameters).called(1);
    verify(generateClassName(constructor)).called(1);
    verifyNoMoreInteractions(generateClassName);
    verifyNoMoreInteractions(constructor);
  });

  test('should check null and don\'t add argument', () {
    const checkNull = true;
    final constructor = ConstructorElementMock();
    final name = 'name';
    final params = <ParameterElement>[];
    final className = 'ClassName';

    when(generateClassName(constructor)).thenReturn(className);
    when(constructor.name).thenReturn(name);
    when(constructor.parameters).thenReturn(params);

    final actual = useCase(constructor, checkNull);

    expect(actual, """
       if (this is $className && $name != null) {
          return $name();
        }
      """);
    verify(constructor.name).called(1);
    verify(constructor.parameters).called(1);
    verify(generateClassName(constructor)).called(1);
    verifyNoMoreInteractions(generateClassName);
    verifyNoMoreInteractions(constructor);
  });
}
