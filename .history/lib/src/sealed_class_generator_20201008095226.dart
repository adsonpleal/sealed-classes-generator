import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:meta/meta.dart';


class SealedClassGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final annotatedClasses = library.annotatedClasses;

    if (annotatedClasses.isNotEmpty) {


      return '''

     
      ''';
    }
    return null;
  }
}

extension on LibraryReader {
  Iterable<ClassElement> get annotatedClasses =>
      annotatedWith(TypeChecker.fromRuntime(sealed.runtimeType))
          .map((e) => e.element)
          .whereType<ClassElement>();
}
