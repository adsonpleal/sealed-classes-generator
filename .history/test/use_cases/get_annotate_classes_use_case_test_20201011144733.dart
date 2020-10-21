import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/get_annotate_classes_use_case.dart';

import '../mocks.dart';

void main() {
  test('should filter class elements with sealed annotation', () {
    final useCase = GetAnnotatedClassesUseCase();
    final classElement1 = ClassElementMock();
    final classElement2 = ClassElementMock();
    final libraryReader = LibraryReaderMock();
    final allElements = [
      classElement1,
      classElement2,
      ClassElementMock(),
      ParameterElementMock(),
      ConstructorElementMock(),
    ];

    when(classElement1.hasSealed).thenReturn(true);
    when(classElement2.hasSealed).thenReturn(true);
    when(libraryReader.allElements).thenReturn(allElements);

    final actual = useCase(libraryReader);

    expect(actual, [classElement1, classElement2]);
    
  });
}
