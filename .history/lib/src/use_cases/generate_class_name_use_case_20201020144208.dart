import '../extensions/string_extension.dart';

class GenerateClassNameUseCase {
  String call(String name, String parent) => '$parent${name.capitalize()}';
}
