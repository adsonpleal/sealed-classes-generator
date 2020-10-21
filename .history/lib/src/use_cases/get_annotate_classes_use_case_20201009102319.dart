import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

class GetAnnotatedClassesUseCase {
  Iterable<ClassElement> call(LibraryBuilder libraryBuilder) =>
      libraryBuilder.allElements
          .whereType<ClassElement>()
          .where((e) => e.hasSealed);
}
