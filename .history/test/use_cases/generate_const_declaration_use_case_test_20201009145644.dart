import 'package:flutter_test/flutter_test.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_const_declaration_use_case.dart';

void main() {
  GenerateConstDeclarationUseCase useCase;

  setUp(() {
    useCase = GenerateConstDeclarationUseCase();
  });

  test('should return empty string for false isConst', () {
    const isConst = false;

    final actual = useCase(isConst);

    expect(actual, '');
  });

  test('should return const for true isConst', () {
    const isConst = true;

    final actual = useCase(isConst);

    expect(actual, 'const');
  });
}
