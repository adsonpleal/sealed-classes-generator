import 'package:analyzer/dart/element/element.dart';















class GenerateClassDeclarationUseCase {
  const GenerateClassDeclarationUseCase(
    this._generateParamsDeclarations,
    this._generateClassConstructor,
    this._generatePropsParams,
  );

  final GenerateParamsDeclarationsUseCase _generateParamsDeclarations;
  final GenerateClassConstructorUseCase _generateClassConstructor;
  final GeneratePropsParamsUseCase _generatePropsParams;

  String call(ConstructorElement constructor, String parent) {
    final name = constructor.name;
    final parameters = constructor.parameters;

    final paramsDeclarations = _generateParamsDeclarations(parameters);
    final constructorDeclaration = _generateClassConstructor(constructor);
    final propsParams = _generatePropsParams(parameters);
    return """
      class _\$$name extends Equatable implements $parent {
        $constructorDeclaration

        $paramsDeclarations

        @override
        List<Object> get props => [$propsParams];
      }
    """;
  }
}
