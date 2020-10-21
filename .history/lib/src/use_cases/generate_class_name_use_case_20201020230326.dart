import 'package:analyzer/dart/element/element.dart';

class GenerateClassNameUseCase {
  String call(ConstructorElement constructor) {
    final parent = constructor.returnType.getDisplayString();
    final name = constructor.name;
    final declarationRegex = RegExp(
      '$parent\\.$name\\((?:.^[$parent\\.]|\\n)*\\) ?= ?(.*);',
    );
    print(declarationRegex);
    return declarationRegex
        .firstMatch(constructor.source.contents.data)
        .group(1);
  }
}
