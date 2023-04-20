part of 'controls_bloc.dart';

abstract class ControlsState extends Equatable {
  const ControlsState();

  @override
  List<Object> get props => [];
}

class ControlsInitial extends ControlsState {}

class ControlsShown extends ControlsState {}

class ControlsHidden extends ControlsState {}
