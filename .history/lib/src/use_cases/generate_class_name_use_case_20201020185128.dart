import 'package:analyzer/dart/element/element.dart';

class GenerateClassNameUseCase {
  String call(ConstructorElement constructor) {
    final typeDeclaration = constructor.source.contents.data.split(' = ')[1];
    return typeDeclaration.substring(0, typeDeclaration.length - 1);
  }
}
