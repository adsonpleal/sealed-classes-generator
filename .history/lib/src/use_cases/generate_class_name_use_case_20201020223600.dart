import 'package:analyzer/dart/element/element.dart';

class GenerateClassNameUseCase {
  String call(ConstructorElement constructor) {
    final parent = constructor.returnType.getDisplayString();
    final name = constructor.name;
    final declarationRegex = RegExp('$parent\\.$name\\((.|\\n)\\) ?= ?(.*);');
    print(declarationRegex);
    final firstMatch =
        declarationRegex.firstMatch(constructor.source.contents.data);
    return firstMatch.group(firstMatch.groupCount - 1);
  }
}
