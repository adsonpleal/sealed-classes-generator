import 'package:analyzer/dart/element/element.dart';

import 'generate_code_for_class_use_case.dart';

class BuildGeneratedCodeUseCase {
  const BuildGeneratedCodeUseCase(this._generateCode);

  final GenerateCodeForClassUseCase _generateCode;

  String call(List<ClassElement> classes) {
    return classes.map(_generateCode).join('\n');
  }
}
