import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/build_generated_code_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_code_for_class_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateCodeForClassUseCase generateCode;
  BuildGeneratedCodeUseCase useCase;

  setUp(() {
    generateCode = GenerateCodeForClassUseCaseMock();
    useCase = BuildGeneratedCodeUseCase(generateCode);
  });
  test('should join mapped results', () {
    final classElement1 = ClassElementMock();
    final classElement2 = ClassElementMock();

    when(generateCode(classElement1)).thenReturn('classElement1');
    when(generateCode(classElement2)).thenReturn('classElement2');

    final classElementList = [classElement1, classElement2];

    final actual = useCase(classElementList);

    verify(generateCode(classElement1)).called(1);
    verify(generateCode(classElement2)).called(1);
    verifyNoMoreInteractions(generateCode);

    expect(actual, "classElement1\nclassElement21");
  });
}
