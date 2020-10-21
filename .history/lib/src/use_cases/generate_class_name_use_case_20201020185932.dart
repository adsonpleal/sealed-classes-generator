import 'package:analyzer/dart/element/element.dart';

class GenerateClassNameUseCase {
  String call(ConstructorElement constructor) {
    final name = constructor.name;
    return constructor.source.contents.data.split(' = ')[1].split(';').first;
  }
}
