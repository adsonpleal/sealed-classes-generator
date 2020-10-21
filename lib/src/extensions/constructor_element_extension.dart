import 'package:analyzer/dart/element/element.dart';

extension HasParams on ConstructorElement {
  bool get hasParams => parameters.isNotEmpty;
}
