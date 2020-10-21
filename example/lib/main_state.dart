import 'package:equatable/equatable.dart';
import 'package:example/models/some_error.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'main_state.g.dart';

@sealed
class MainState {
  const factory MainState.initial() = MainStateInitial._;
  const factory MainState.loading() = MainStateLoading._;
  const factory MainState.error(SomeError error) = MainStateError._;
  const factory MainState.finished(
    String message, {
    @required int value,
  }) = MainStateFinished._;
}
