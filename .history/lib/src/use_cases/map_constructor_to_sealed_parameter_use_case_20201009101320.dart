import 'package:analyzer/dart/element/element.dart';

import '../extensions/constructor_element_extension.dart';

class MapConstructorToSealedParameterUseCase {
  String call(ConstructorElement constructor, bool isRequired) {
    final name = constructor.name;
    final functionParam = constructor.hasParams ? "_\$$name" : '';
    return "${isRequired ? '@required' : ''} T Function($functionParam) $name";
  }
}
