part of 'test_bloc.dart';

abstract class TestState extends Equatable {
  const TestState();

  @override
  List<Object> get props => [];
}

class TestInitialState extends TestState {}

class TestPlayingState extends TestState {
  final VideoPlayerController controller;
  const TestPlayingState({required this.controller});

  @override
  List<Object> get props => [controller];
}

class TestBufferingState extends TestState {
  final VideoPlayerController controller;
  const TestBufferingState({required this.controller});

  @override
  List<Object> get props => [controller];
}

class TestPausedState extends TestState {
  final VideoPlayerController controller;
  const TestPausedState({required this.controller});

  @override
  List<Object> get props => [controller];
}

class TestLoadingState extends TestState {}

class TestLoadedState extends TestState {
  final VideoPlayerController controller;
  const TestLoadedState({required this.controller});
}
class TestUpdateTimesState extends TestState {
  final VideoPlayerController controller;
  const TestUpdateTimesState({required this.controller});
}
