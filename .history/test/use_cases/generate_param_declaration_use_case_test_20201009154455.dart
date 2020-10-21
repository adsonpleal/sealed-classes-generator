import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_param_declaration_use_case.dart';

import '../mocks.dart';

void main() {
  test('should generate param declaration', () {
    final type = "Type";
    final name = "name";
    final param = ParameterElementMock();
    final useCase = GenerateParamDeclarationUseCase();
    
    when(param.type.getDisplayString()).thenReturn(type);
    when(param.name).thenReturn(name);

    final actual = useCase(param);

    expect(actual, matcher)
  });
}