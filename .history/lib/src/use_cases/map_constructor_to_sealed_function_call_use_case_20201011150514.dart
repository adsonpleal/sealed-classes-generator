import 'package:analyzer/dart/element/element.dart';

import '../extensions/constructor_element_extension.dart';

class MapConstructorToSealedFunctionCallUseCase {
  String call(ConstructorElement constructor, bool checkNull) {
    final name = constructor.name;
    final nullCheck = checkNull ? " && $name != null" : '';
    final argument = constructor.hasParams ? "this as _\$$name" : '';
    return """
       if (this is _\$$name$nullCheck) {
          return $name($argument);
        }
      """;
  }
}
