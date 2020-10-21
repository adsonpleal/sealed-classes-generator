import 'package:analyzer/dart/element/element.dart';

class GenerateClassNameUseCase {
  String call(ConstructorElement constructor) {
    return constructor.source.toString();
  }
}
