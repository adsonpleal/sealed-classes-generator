import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../annotations.dart';

class SealedClassGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final annotatedClasses = library.annotatedClasses;

    for(final annotatedClass in annotatedClasses) {
      annotatedClass.hasSealed
    }
    if (annotatedClasses.length > 0) {
      return '''

     
      ''';
    }
    return null;
  }
}

extension on LibraryReader {
  Iterable<ClassElement> get annotatedClasses =>
      annotatedWith(TypeChecker.fromRuntime(sealed))
          .map((e) => e.element)
          .whereType<ClassElement>();
}
