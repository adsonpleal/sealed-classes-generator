import 'package:analyzer/dart/element/element.dart';

class GenerateClassDeclarationUseCase {
  String call(ConstructorElement constructor, String parent) {
    final name = constructor.name;
    final isConst = constructor.isConst;
    final paramsDeclarations = constructor.parameters
        .map((param) => "final ${param.type.getDisplayString()} ${param.name};")
        .join('\n');
    final paramsNames = constructor.parameters.map((param) => param.name);
    final propsParams = paramsNames.join(',');
    final positionalConstructorParams = constructor.parameters
        .where((param) => param.isPositional)
        .map((param) => "this.${param.name}")
        .join(',');

    final namedConstructorParams = constructor.parameters
        .where((param) => param.isNamed)
        .map((param) => "this.${param.name}")
        .join(',');

    final fullNamedConstructorParams =
        namedConstructorParams.isNotEmpty ? "{${namedConstructorParams},}" : '';
    final fullPositionalConstructorParams =
        positionalConstructorParams.isNotEmpty
            ? "${positionalConstructorParams},"
            : '';
    return """
      class _\$$name extends Equatable implements $parent {
        ${isConst ? 'const' : ''} _\$$name($fullPositionalConstructorParams$fullNamedConstructorParams);

        ${paramsDeclarations}

        @override
        List<Object> get props => [$propsParams];
      }
    """;
  }
}
