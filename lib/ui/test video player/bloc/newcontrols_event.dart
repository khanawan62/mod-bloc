part of 'newcontrols_bloc.dart';

abstract class NewcontrolsEvent extends Equatable {
  const NewcontrolsEvent();

  @override
  List<Object> get props => [];
}

class ToggleNewControlsRightAway extends NewcontrolsEvent {}

class HideNewControlsAfterDelay extends NewcontrolsEvent {}
