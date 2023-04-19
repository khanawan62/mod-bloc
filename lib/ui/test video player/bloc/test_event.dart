part of 'test_bloc.dart';

abstract class TestEvent extends Equatable {
  const TestEvent();

  @override
  List<Object> get props => [];
}

class TestInitEvent extends TestEvent {}

class TestPlayEvent extends TestEvent {}

class TestPausedEvent extends TestEvent {}

class TestToggleEvent extends TestEvent {}

class TestMoveEvent extends TestEvent {}

class TestNextEvent extends TestEvent {}
