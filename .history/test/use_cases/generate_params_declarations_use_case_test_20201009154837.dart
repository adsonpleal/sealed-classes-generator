import 'package:flutter_test/flutter_test.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_param_declaration_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_params_declarations_use_case.dart';

import '../mocks.dart';

void main() {
  GenerateParamDeclarationUseCase generateParamDeclaration;
  GenerateParamsDeclarationsUseCase useCase;

  setUp(() {
    generateParamDeclaration = GenerateParamDeclarationUseCaseMock();
    useCase = GenerateParamsDeclarationsUseCase(generateParamDeclaration);
  });

  test('should map and join declarations', () {
    final param1 = 
    
  });
}
