import 'package:analyzer/dart/element/element.dart';

class GeneratePropsParamsUseCase {
  String call(List<ParameterElement> params) {
    return params.map((param) => param.name).join(',');
  }
}
