import 'package:analyzer/dart/element/element.dart';

class GenerateParamDeclarationUseCase {
  String call(ParameterElement param) {
    return "final ${param.type.getDisplayString()} ${param.name};";
  }
}
