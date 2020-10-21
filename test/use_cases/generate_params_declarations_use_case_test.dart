import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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
    final param1 = ParameterElementMock();
    final param2 = ParameterElementMock();
    final params = [param1, param2];

    when(generateParamDeclaration(param1)).thenReturn('param1');
    when(generateParamDeclaration(param2)).thenReturn('param2');

    final actual = useCase(params);

    expect(actual, 'param1\nparam2');
    verify(generateParamDeclaration(param1)).called(1);
    verify(generateParamDeclaration(param2)).called(1);
    verifyNoMoreInteractions(generateParamDeclaration);
    verifyNoMoreInteractions(param1);
    verifyNoMoreInteractions(param2);
  });
}
