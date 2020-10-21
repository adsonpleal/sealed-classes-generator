import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_name_use_case.dart';
import 'package:sealed_classes_generator/src/extensions/string_extension.dart';

import '../mocks.dart';

void main() {
  GenerateClassNameUseCase useCase;

  setUp(() {
    useCase = GenerateClassNameUseCase();
  });

  test('should append parent and capitalize', () {
    final constructor = ConstructorElementMock();
    final name = 'FakeName';

    when(constructor.redirectedConstructor).thenReturn(constructor);
    when(constructor.displayName).thenReturn(name);

    final actual = useCase(constructor);

    expect(actual, name);
    verify(constructor.redirectedConstructor).called(1);
    verify(constructor.displayName).called(1);
    verifyNoMoreInteractions(constructor);
  });
}
