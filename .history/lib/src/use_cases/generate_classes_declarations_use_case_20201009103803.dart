import 'package:analyzer/dart/element/element.dart';

import 'generate_class_declaration_use_case.dart';

class GenerateClassesDeclarationsUseCase {
  const GenerateClassesDeclarationsUseCase(this._generateDeclaration);

  final GenerateClassDeclarationUseCase _generateDeclaration;

  String call(ClassElement classElement) {
    final parent = classElement.name;
    return classElement.constructors
        .map((constructor) => _generateDeclaration(constructor, parent))
        .join('\n');
  }
}
