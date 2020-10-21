import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'main_event.g.dart';

@sealed
class MainEvent {
  const factory MainEvent.start() = MainEventStart;
  const factory MainEvent.triggerError(String message) = MainEventTriggerError;
  const factory MainEvent.back() = MainEventBack;
}
