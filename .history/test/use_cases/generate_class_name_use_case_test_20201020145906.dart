import 'package:flutter_test/flutter_test.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_name_use_case.dart';
import 'package:sealed_classes_generator/src/extensions/string_extension.dart';

void main() {
  GenerateClassNameUseCase useCase;

  setUp(() {
    useCase = GenerateClassNameUseCase();
  });

  test('should append parent and capitalize', () {
    const name = 'fakeName';
    const parent = 'Parent';

    final actual = useCase(name, parent);
    expect(actual, '$parent${name.capitalize()}');
  });
}
