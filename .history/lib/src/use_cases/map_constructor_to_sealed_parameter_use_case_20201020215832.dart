import 'package:analyzer/dart/element/element.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_name_use_case.dart';

import '../extensions/constructor_element_extension.dart';

class MapConstructorToSealedParameterUseCase {
  const MapConstructorToSealedParameterUseCase(this._generateClassName);
  final GenerateClassNameUseCase _generateClassName;


  String call(ConstructorElement constructor, bool isRequired) {
    final name = constructor.name;
    final className = _generateClassName(constructor);
    final functionParam = constructor.hasParams ? "$className" : '';
    return "${isRequired ? '@required ' : ''}T Function($functionParam) $name";
  }
}
