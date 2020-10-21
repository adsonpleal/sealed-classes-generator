import 'package:flutter_test/flutter_test.dart';
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
    final classElement1 = 
  });
}
