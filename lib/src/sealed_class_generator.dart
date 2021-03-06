import 'package:build/build.dart';
import "package:source_gen/source_gen.dart";

import 'use_cases/build_generated_code_use_case.dart';
import 'use_cases/get_annotate_classes_use_case.dart';

class SealedClassGenerator extends Generator {
  const SealedClassGenerator(
    this._buildGeneratedCode,
    this._getAnnotateClasses,
  );

  final BuildGeneratedCodeUseCase _buildGeneratedCode;
  final GetAnnotatedClassesUseCase _getAnnotateClasses;

  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final annotatedClasses = _getAnnotateClasses(library);

    if (annotatedClasses.isNotEmpty) {
      return _buildGeneratedCode(annotatedClasses);
    }
    return null;
  }
}
