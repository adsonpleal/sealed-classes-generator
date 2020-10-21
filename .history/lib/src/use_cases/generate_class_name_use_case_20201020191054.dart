import 'package:analyzer/dart/element/element.dart';

class GenerateClassNameUseCase {
  String call(ConstructorElement constructor) {
    final name = constructor.name;
    final declarationRegex = RegExp('$name.* = (.*);');
    return declarationRegex
        .firstMatch(constructor.source.contents.data)
        .group(0);
  }
}
