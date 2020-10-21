import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/generated/timestamped_data.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_constructor_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_declaration_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_class_name_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_classes_declarations_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_code_for_class_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_const_declaration_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_constructor_params_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_constructor_params_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_named_constructor_params_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_positional_constructor_params_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_param_declaration_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_params_declarations_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_props_params_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_extension_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_function_calls_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_sealed_parameters_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/map_constructor_to_sealed_function_call_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/map_constructor_to_sealed_parameter_use_case.dart';

class ClassElementMock extends Mock implements ClassElement {}

class MapConstructorToSealedParameterUseCaseMock extends Mock
    implements MapConstructorToSealedParameterUseCase {}

class MapConstructorToSealedFunctionCallUseCaseMock extends Mock
    implements MapConstructorToSealedFunctionCallUseCase {}

class GenerateSealedParametersUseCaseMock extends Mock
    implements GenerateSealedParametersUseCase {}

class GenerateSealedFunctionCallsUseCaseMock extends Mock
    implements GenerateSealedFunctionCallsUseCase {}

class DartTypeMock extends Mock implements DartType {}

class GenerateParamDeclarationUseCaseMock extends Mock
    implements GenerateParamDeclarationUseCase {}

class GeneratePositionalConstructorParamsUseCaseMock extends Mock
    implements GeneratePositionalConstructorParamsUseCase {}

class GenerateNamedConstructorParamsUseCaseMock extends Mock
    implements GenerateNamedConstructorParamsUseCase {}

class GenerateFullPositionalConstructorParamsUseCaseMock extends Mock
    implements GenerateFullPositionalConstructorParamsUseCase {}

class GenerateFullNamedConstructorParamsUseCaseMock extends Mock
    implements GenerateFullNamedConstructorParamsUseCase {}

class GenerateSealedExtensionUseCaseMock extends Mock
    implements GenerateSealedExtensionUseCase {}

class GenerateClassesDeclarationsUseCaseMock extends Mock
    implements GenerateClassesDeclarationsUseCase {}

class GenerateClassDeclarationUseCaseMock extends Mock
    implements GenerateClassDeclarationUseCase {}

class ParameterElementMock extends Mock implements ParameterElement {}

class InterfaceTypeMock extends Mock implements InterfaceType {}

class SourceMock extends Mock implements Source {}
class TimestampedDataMock<T> extends Mock implements TimestampedData<T> {}

class GenerateClassConstructorUseCaseMock extends Mock
    implements GenerateClassConstructorUseCase {}

class GeneratePropsParamsUseCaseMock extends Mock
    implements GeneratePropsParamsUseCase {}

class GenerateClassNameUseCaseMock extends Mock
    implements GenerateClassNameUseCase {}

class GenerateParamsDeclarationsUseCaseMock extends Mock
    implements GenerateParamsDeclarationsUseCase {}

class ConstructorElementMock extends Mock implements ConstructorElement {}

class GenerateFullConstructorParamsUseCaseMock extends Mock
    implements GenerateFullConstructorParamsUseCase {}

class GenerateConstDeclarationUseCaseMock extends Mock
    implements GenerateConstDeclarationUseCase {}

class GenerateCodeForClassUseCaseMock extends Mock
    implements GenerateCodeForClassUseCase {}
