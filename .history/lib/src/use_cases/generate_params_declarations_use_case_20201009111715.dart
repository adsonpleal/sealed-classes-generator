import 'package:analyzer/dart/element/element.dart';

import 'generate_param_declaration_use_case.dart';

class GenerateParamsDeclarationsUseCase {
  const GenerateParamsDeclarationsUseCase(this._generateParamDeclaration);

  final GenerateParamDeclarationUseCase _generateParamDeclaration;

  String call(List<ParameterElement> params) {
    return params.map(_generateParamDeclaration).join('\n');
  }
}
