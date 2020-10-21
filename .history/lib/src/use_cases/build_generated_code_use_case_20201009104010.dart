import 'package:analyzer/dart/element/element.dart';

import '../sealed_class_generator.dart';

class BuildGeneratedCodeUseCase {
  const BuildGeneratedCodeUseCase(this._generateCode);

  final GenerateCodeForClassUseCase _generateCode;

  String call(List<ClassElement> classes) {
    return classes.map(_generateCode).join('\n');
  }
}