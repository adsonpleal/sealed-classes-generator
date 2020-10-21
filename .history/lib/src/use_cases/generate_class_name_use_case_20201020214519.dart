import 'package:analyzer/dart/element/element.dart';

class GenerateClassNameUseCase {
  String call(ConstructorElement constructor, String parent) {
    final name = constructor.name;
    final declarationRegex = RegExp('$parent.$name.*(.*) = (.*);');
    return declarationRegex
        .firstMatch(constructor.source.contents.data)
        .group(1);
  }
}
