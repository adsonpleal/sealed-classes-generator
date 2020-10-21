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
