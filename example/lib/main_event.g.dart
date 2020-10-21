// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_event.dart';

// **************************************************************************
// SealedClassGenerator
// **************************************************************************

class MainEventStart extends Equatable implements MainEvent {
  const MainEventStart._();

  @override
  List<Object> get props => [];
}

class MainEventTriggerError extends Equatable implements MainEvent {
  const MainEventTriggerError._(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];
}

class MainEventBack extends Equatable implements MainEvent {
  const MainEventBack._();

  @override
  List<Object> get props => [];
}

extension SealedMainEvent on MainEvent {
  // ignore: missing_return
  T when<T>({
    @required T Function() start,
    @required T Function(MainEventTriggerError) triggerError,
    @required T Function() back,
  }) {
    if (this is MainEventStart) {
      return start();
    } else if (this is MainEventTriggerError) {
      return triggerError(this as MainEventTriggerError);
    } else if (this is MainEventBack) {
      return back();
    }
  }

  T whenDefault<T>({
    T Function() start,
    T Function(MainEventTriggerError) triggerError,
    T Function() back,
    @required T Function() defaultAction,
  }) {
    if (this is MainEventStart && start != null) {
      return start();
    } else if (this is MainEventTriggerError && triggerError != null) {
      return triggerError(this as MainEventTriggerError);
    } else if (this is MainEventBack && back != null) {
      return back();
    } else {
      return defaultAction();
    }
  }
}
