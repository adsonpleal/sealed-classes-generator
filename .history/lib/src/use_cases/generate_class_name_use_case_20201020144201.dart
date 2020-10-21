import '../extensions/string_extension.dart';

class GenerateClassNameUseCase {
  String call(String name, String parent) {
    return '$parent${name.capitalize()}';
  }
}
