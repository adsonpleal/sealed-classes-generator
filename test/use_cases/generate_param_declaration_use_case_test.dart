import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_param_declaration_use_case.dart';

import '../mocks.dart';

void main() {
  test('should generate param declaration', () {
    final typeName = "Type";
    final name = "name";
    final param = ParameterElementMock();
    final useCase = GenerateParamDeclarationUseCase();
    final type = DartTypeMock();

    when(param.type).thenReturn(type);
    when(type.getDisplayString()).thenReturn(typeName);
    when(param.name).thenReturn(name);

    final actual = useCase(param);

    expect(actual, "final $typeName $name;");
    verify(type.getDisplayString()).called(1);
    verify(param.name).called(1);
    verify(param.type).called(1);
    verifyNoMoreInteractions(type);
    verifyNoMoreInteractions(param);
  });
}
