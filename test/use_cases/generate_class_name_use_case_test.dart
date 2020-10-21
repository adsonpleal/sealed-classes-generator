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
    const expectedClassName = 'FakeClassName';
    const sourceCode = """
    const factory $className.$name({
      fakeParam1: 'fake1',
      fakeParam2: 'fake2',
    }) = $expectedClassName._;
    const factory $className.initial() = ${className}Initial._;
    const factory $className.loading() = ${className}Loading._;
    const factory $className.error(SomeError error) = ${className}Error._;
    const factory $className.finished(
      String message, {
      @required int value,
    }) = ${className}Finished._;
    """;

    when(constructor.returnType).thenReturn(returnType);
    when(constructor.name).thenReturn(name);
    when(constructor.source).thenReturn(source);
    when(source.contents).thenReturn(contents);
    when(contents.data).thenReturn(sourceCode);
    when(returnType.getDisplayString()).thenReturn(className);

    final actual = useCase(constructor);

    expect(actual, expectedClassName);
    verify(constructor.returnType).called(1);
    verify(constructor.name).called(1);
    verify(constructor.source).called(1);
    verify(source.contents).called(1);
    verify(contents.data).called(1);
    verify(returnType.getDisplayString()).called(1);
    verifyNoMoreInteractions(constructor);
    verifyNoMoreInteractions(source);
    verifyNoMoreInteractions(contents);
    verifyNoMoreInteractions(returnType);
  });

  test('should append parent and capitalize', () {
    final constructor = ConstructorElementMock();
    final returnType = InterfaceTypeMock();
    final source = SourceMock();
    final contents = TimestampedDataMock<String>();
    const className = 'ClassName';
    const name = 'fakeName';
    const expectedClassName = 'FakeClassName';
    const sourceCode =
        """const factory $className.$name() = $expectedClassName._;""";

    when(constructor.returnType).thenReturn(returnType);
    when(constructor.name).thenReturn(name);
    when(constructor.source).thenReturn(source);
    when(source.contents).thenReturn(contents);
    when(contents.data).thenReturn(sourceCode);
    when(returnType.getDisplayString()).thenReturn(className);

    final actual = useCase(constructor);

    expect(actual, expectedClassName);
    verify(constructor.returnType).called(1);
    verify(constructor.name).called(1);
    verify(constructor.source).called(1);
    verify(source.contents).called(1);
    verify(contents.data).called(1);
    verify(returnType.getDisplayString()).called(1);
    verifyNoMoreInteractions(constructor);
    verifyNoMoreInteractions(source);
    verifyNoMoreInteractions(contents);
    verifyNoMoreInteractions(returnType);
  });
}
