import 'package:analyzer/dart/element/element.dart';
import 'package:mockito/mockito.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_code_for_class_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_const_declaration_use_case.dart';
import 'package:sealed_classes_generator/src/use_cases/generate_full_constructor_params_use_case.dart';

class ClassElementMock extends Mock implements ClassElement {}

class ConstructorElementMock extends Mock implements ConstructorElement {}

class GenerateFullConstructorParamsUseCaseMock extends Mock
    implements GenerateFullConstructorParamsUseCase {}

class GenerateConstDeclarationUseCaseMock extends Mock
    implements GenerateConstDeclarationUseCase {}

class GenerateCodeForClassUseCaseMock extends Mock
    implements GenerateCodeForClassUseCase {}
