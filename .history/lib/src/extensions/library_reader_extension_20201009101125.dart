import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

extension on LibraryReader {
  Iterable<ClassElement> get annotatedClasses =>
      allElements.whereType<ClassElement>().where((e) => e.hasSealed);
}
