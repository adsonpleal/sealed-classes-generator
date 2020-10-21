// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_state.dart';

// **************************************************************************
// SealedClassGenerator
// **************************************************************************

class MainStateInitial extends Equatable implements MainState {
  const MainStateInitial();

  @override
  List<Object> get props => [];
}

class MainStateLoading extends Equatable implements MainState {
  const MainStateLoading();

  @override
  List<Object> get props => [];
}

class MainStateError extends Equatable implements MainState {
  const MainStateError(
    this.error,
  );

  final SomeError error;

  @override
  List<Object> get props => [error];
}

class MainStateFinished extends Equatable implements MainState {
  const MainStateFinished(
    this.message, {
    this.value,
  });

  final String message;
  final int value;

  @override
  List<Object> get props => [message, value];
}

extension SealedMainState on MainState {
  // ignore: missing_return
  T when<T>({
    @required T Function() initial,
    @required T Function() loading,
    @required T Function(MainStateError) error,
    @required T Function(MainStateFinished) finished,
  }) {
    if (this is MainStateInitial) {
      return initial();
    } else if (this is MainStateLoading) {
      return loading();
    } else if (this is MainStateError) {
      return error(this as MainStateError);
    } else if (this is MainStateFinished) {
      return finished(this as MainStateFinished);
    }
  }

  T whenDefault<T>({
    T Function() initial,
    T Function() loading,
    T Function(MainStateError) error,
    T Function(MainStateFinished) finished,
    @required T Function() defaultAction,
  }) {
    if (this is MainStateInitial && initial != null) {
      return initial();
    } else if (this is MainStateLoading && loading != null) {
      return loading();
    } else if (this is MainStateError && error != null) {
      return error(this as MainStateError);
    } else if (this is MainStateFinished && finished != null) {
      return finished(this as MainStateFinished);
    } else {
      return defaultAction();
    }
  }
}
