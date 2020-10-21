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
    final contents = TimestampedDataMock<String>();
    const className = 'ClassName';
    const name = 'fakeName';
    const expectedClassName = 'MainEventStart';
    const sourceCode = 'const factory MainEvent.start() = $expectedClassName;';

    when(constructor.returnType).thenReturn(returnType);
    when(constructor.name).thenReturn(name);
    when(constructor.source).thenReturn(source);
    when(source.contents).thenReturn(contents);
    when(contents.data).thenReturn(sourceCode);
    when(returnType.getDisplayString()).thenReturn(className);

    final actual = useCase(constructor);

    expect(actual, expectedClassName);
    verify(constructor.redirectedConstructor).called(1);
    verify(constructor.displayName).called(1);
    verifyNoMoreInteractions(constructor);
  });
}