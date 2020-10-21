import 'package:analyzer/dart/element/element.dart';

class GenerateClassNameUseCase {
  String call(ConstructorElement constructor) {
    final parent = constructor.returnType.getDisplayString();
    final name = constructor.name;
    final declarationRegex = RegExp('$parent\\.$name\\((?:.|\\n)*\\) ?= ?(.*);');
    final firstMatch =
        declarationRegex.firstMatch(constructor.source.contents.data);
        print(firstMatch.group(0));
        print(firstMatch.group(1));
        print(firstMatch.group(2));
    return firstMatch.group(firstMatch.groupCount -1);
  }
}
