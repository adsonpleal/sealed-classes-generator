import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_name_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateClassNameUseCase useCase;

  setUp(() {
    useCase = GenerateClassNameUseCase();
  });

  test('should append parent and capitalize', () {
    final constructor = ConstructorElementMock();
    final returnType = InterfaceTypeMock();
    final source = SourceMock();
    final contents = TimestampedDataMock();
    final className = 'ClassName';
    final name = 'fakeName';

    when(constructor.returnType).thenReturn(returnType);
    when(constructor.name).thenReturn(name);
    when(constructor.source).thenReturn(source);
    when(source.contents).thenReturn(contents);

    final actual = useCase(constructor);

    expect(actual, name);
    verify(constructor.redirectedConstructor).called(1);
    verify(constructor.displayName).called(1);
    verifyNoMoreInteractions(constructor);
  });
}
