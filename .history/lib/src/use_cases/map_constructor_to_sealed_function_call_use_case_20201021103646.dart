import 'package:analyzer/dart/element/element.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_name_use_case.dart';

import '../extensions/constructor_element_extension.dart';

class MapConstructorToSealedFunctionCallUseCase {
  const MapConstructorToSealedFunctionCallUseCase(this._generateClassName);

  final GenerateClassNameUseCase _generateClassName;

  String call(ConstructorElement constructor, bool checkNull) {
    final className = _generateClassName(constructor);
    final name = constructor.name;
    final nullCheck = checkNull ? " && $name != null" : '';
    final argument = constructor.hasParams ? "this as $className" : '';
    return """
       if (this is $className$nullCheck) {
          return $name($argument);
        }
      """;
  }
}
