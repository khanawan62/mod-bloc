part of 'controls_bloc.dart';

abstract class ControlsEvent extends Equatable {
  const ControlsEvent();

  @override
  List<Object> get props => [];
}

class ControlsToggleRightAwayPressed extends ControlsEvent {}

class ControlsHideAfterDelayPressed extends ControlsEvent {}
