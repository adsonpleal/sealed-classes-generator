# Sealed class Code Generator

A Dart package that generates code for classes annotated with `@sealed` annotation

## Pub

TODO

## @sealed Annotation

The **@sealed** annotation is part of Flutter's `meta` package. This annotation marks a class as not allowed as a super-type. So we take advantage of this behaviour and add some code generation to make its behavior closer to kotlin's `sealed class`. More info about the **@sealed** annotation on [Flutter official documentation](https://api.flutter.dev/flutter/meta/sealed-constant.html).

Classes annotated with **@sealed** will trigger code generation.

## Equatable

This package uses [Equatable](https://pub.dev/packages/equatable) on the generated classes. So you need to add it as a depencency on your project. See example to more information.

## How it works

By adding the annotation to a class that you want to make sealed:

```dart
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'main_event.g.dart';

@sealed
class MainEvent {
  const factory MainEvent.start() = MainEventStart._;
  const factory MainEvent.triggerError(String message) = MainEventTriggerError._;
  const factory MainEvent.back() = MainEventBack._;
}
```

And running
```bash
pub run build_runner build --delete-conflicting-outputs
```

The generator will create the `main_event.g.dart` file for you:

```dart
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
```

It gets the classes annotated with **@sealed** and generate the sub classess and two helper functions to emulate Kotlin's `when`.

To use the generated `when` extension you can do like this (or check example): 

```dart
import 'package:bloc/bloc.dart';
import 'package:example/main_state.dart';

import 'main_event.dart';
import 'models/some_error.dart';
import 'models/some_information.dart';

class FakeRepository {
  Future<SomeInformation> getSomeInformation() async {
    await Future.delayed(Duration(seconds: 1));
    return SomeInformation(message: 'Some message', value: 10);
  }
}

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.initial());

  final repository = FakeRepository();

  @override
  Stream<MainState> mapEventToState(MainEvent event) => event.when(
        start: _mapStartToState,
        triggerError: _mapTriggerErrorToState,
        back: _mapBackToState,
      );

  Stream<MainState> _mapStartToState() async* {
    yield MainState.loading();
    final someInfo = await repository.getSomeInformation();
    yield MainState.finished(someInfo.message, value: someInfo.value);
  }

  Stream<MainState> _mapTriggerErrorToState(
    MainEventTriggerError event,
  ) async* {
    yield MainState.error(SomeError("code", event.message));
  }

  Stream<MainState> _mapBackToState() async* {
    yield MainState.initial();
  }
}
```

## Examples

- [Example](https://github.com/adsonpleal/sealed-classes-generator/tree/master/example) - an example of how to use sealed_classes_generator

### Maintainers

- [Adson Leal](https://github.com/adsonpleal)
