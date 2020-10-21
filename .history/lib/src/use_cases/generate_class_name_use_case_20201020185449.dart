import 'package:analyzer/dart/element/element.dart';

class GenerateClassNameUseCase {
  String call(ConstructorElement constructor) {
    return constructor..contents.data.split(' = ')[1].split(';').first;
  }
}
