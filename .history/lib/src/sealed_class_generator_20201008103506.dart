import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class SealedClassGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final annotatedClasses = library.annotatedClasses;

    if (annotatedClasses.isNotEmpty) {
      return '''

class _\$loading extends Equatable implements TestState {
  const _\$loading();

  @override
  List<Object> get props => null;
}

class _\$finished extends Equatable implements TestState {
  const _\$finished(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class _\$error extends Equatable implements TestState {
  const _\$error();

  @override
  List<Object> get props => null;
}

extension SealedTestState on TestState {
  // ignore: missing_return
  T when<T>({
    @required T Function() loading,
    @required T Function(String message) finished,
    @required T Function() error,
  }) {
    if (this is _\$loading) {
      return loading();
    } else if (this is _\$finished) {
      return finished((this as _\$finished).message);
    } else if (this is _\$error) {
      return error();
    }
  }
}
      ''';
    }
    return null;
  }
}

extension on LibraryReader {
  Iterable<ClassElement> get annotatedClasses =>
      allElements.whereType<ClassElement>().where((e) => e.hasSealed);
}
