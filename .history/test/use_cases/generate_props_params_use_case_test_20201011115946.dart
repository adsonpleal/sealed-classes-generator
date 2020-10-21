import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  test('should map param name and join with comma', () {
    final name1 = 'name1';
    final name2 = 'name2';
    final param1 = ParameterElementMock();
    final param2 = ParameterElementMock();
    final params = [param1, param2];
    final useCase = 

    when(param1.name).thenReturn(name1);
    when(param2.name).thenReturn(name2);


  });
}
