import 'package:flutter_test/flutter_test.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_parameters_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/map_constructor_to_sealed_parameter_use_case.dart';

import '../mocks.dart';

void main() {
  MapConstructorToSealedParameterUseCase constructorAsParameter;
  GenerateSealedParametersUseCase useCase;

  setUp(() {
    constructorAsParameter = MapConstructorToSealedParameterUseCaseMock();
    useCase = GenerateSealedParametersUseCase(constructorAsParameter);
  });

  test('should generate param with sufix', () {
    const hasDefault = true;
    
  });
}
