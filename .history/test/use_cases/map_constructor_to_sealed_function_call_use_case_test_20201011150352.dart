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
       if (this is _\$$name $nullCheck) {
          return $name($argument);
        }
      """);
  });
}
