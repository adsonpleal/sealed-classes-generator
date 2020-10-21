import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/sealed_class_generator.dart';
import 'package:sealed_classes_generator/src/use_cases/build_generated_code_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/get_annotate_classes_use_case.dart';

import '../mocks.dart';

void main() {
  BuildGeneratedCodeUseCase buildGeneratedCode;
  GetAnnotatedClassesUseCase getAnnotateClasses;
  SealedClassGenerator generator;

  setUp(() {
    buildGeneratedCode = BuildGeneratedCodeUseCaseMock();
    getAnnotateClasses = GetAnnotatedClassesUseCaseMock();
    generator = SealedClassGenerator(
      buildGeneratedCode,
      getAnnotateClasses,
    );
  });

  test('should generate code if there are annotate classes', () {
    const generatedCode = ''
    final classes = [ClassElementMock(), ClassElementMock()];

    when(getAnnotateClasses(any)).thenReturn(classes);
    when(buildGeneratedCode(classes)).thenReturn(classes);

  });
}
