import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/map_constructor_to_sealed_function_call_use_case.dart';

import '../mocks.dart';

void main() {
  MapConstructorToSealedFunctionCallUseCase useCase;

  setUp(() {
    useCase = MapConstructorToSealedFunctionCallUseCase();
  });

  test('should check null and add argument', () {
    const checkNull = true;
    final constructor = ConstructorElementMock();
    final name = 'name';
    final params = [ParameterElementMock()];

    when(constructor.name).thenReturn(name);
    when(constructor.parameters).thenReturn(params);

    final actual = useCase(constructor, checkNull);

    expect(actual, """
       if (this is _\$$name && $name != null) {
          return $name(this as _\$$name);
        }
      """);
  });

  test('should not check null and add argument', () {
    const checkNull = false;
    final constructor = ConstructorElementMock();
    final name = 'name';
    final params = [ParameterElementMock()];

    when(constructor.name).thenReturn(name);
    when(constructor.parameters).thenReturn(params);

    final actual = useCase(constructor, checkNull);

    expect(actual, """
       if (this is _\$$name) {
          return $name(this as _\$$name);
        }
      """);
  });

  test('should not check null and don\'t add argument', () {
    const checkNull = false;
    final constructor = ConstructorElementMock();
    final name = 'name';
    final params = <ParameterElement>[];

    when(constructor.name).thenReturn(name);
    when(constructor.parameters).thenReturn(params);

    final actual = useCase(constructor, checkNull);

    expect(actual, """
       if (this is _\$$name) {
          return $name();
        }
      """);
  });

  test('should check null and don\'t add argument', () {
    const checkNull = true;
    final constructor = ConstructorElementMock();
    final name = 'name';
    final params = <ParameterElement>[];

    when(constructor.name).thenReturn(name);
    when(constructor.parameters).thenReturn(params);

    final actual = useCase(constructor, checkNull);

    expect(actual, """
       if (this is _\$$name && $name != null) {
          return $name();
        }
      """);
  });
}
