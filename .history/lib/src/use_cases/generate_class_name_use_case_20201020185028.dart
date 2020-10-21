import 'package:analyzer/dart/element/element.dart';

class GenerateClassNameUseCase {
  String call(ConstructorElement constructor) {
    return constructor.source.contents.data.split(' = ')[1].substring(0, -1);
  }
}
