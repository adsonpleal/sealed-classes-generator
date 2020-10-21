import 'package:example/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_event.dart';
import 'main_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;
  final bloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        cubit: bloc,
        builder: (context, state) => state.when(
          initial: () => Initial(
            onStart: () => bloc.add(MainEvent.start()),
            onError: () => bloc.add(MainEvent.triggerError('error message')),
          ),
          loading: () => Loading(),
          error: (state) => Error(
            code: state.error.code,
            message: state.error.message,
            onBack: () => bloc.add(MainEvent.back()),
          ),
          finished: (state) => Finished(
            value: state.value,
            message: state.message,
            onBack: () => bloc.add(MainEvent.back()),
          ),
        ),
      ),
    );
  }
}

class Error extends StatelessWidget {
  const Error({
    Key key,
    @required this.code,
    @required this.message,
    @required this.onBack,
  }) : super(key: key);

  final String code;
  final String message;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("code: $code"),
        Text("message: $message"),
        MaterialButton(
          child: Text('Back'),
          onPressed: onBack,
        ),
      ],
    );
  }
}

class Finished extends StatelessWidget {
  const Finished({
    Key key,
    @required this.value,
    @required this.message,
    @required this.onBack,
  }) : super(key: key);

  final int value;
  final String message;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("value: $value"),
        Text("message: $message"),
        MaterialButton(
          child: Text('Back'),
          onPressed: onBack,
        ),
      ],
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class Initial extends StatelessWidget {
  const Initial({
    Key key,
    @required this.onStart,
    @required this.onError,
  }) : super(key: key);

  final VoidCallback onStart, onError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MaterialButton(
          child: Text('Start process'),
          onPressed: onStart,
        ),
        MaterialButton(
          child: Text('Trigger error'),
          onPressed: onError,
        ),
      ],
    );
  }
}
