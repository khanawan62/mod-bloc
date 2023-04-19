part of 'newcontrols_bloc.dart';

abstract class NewcontrolsState extends Equatable {
  const NewcontrolsState();

  @override
  List<Object> get props => [];
}

class NewcontrolsInitialState extends NewcontrolsState {}

class NewcontrolsHideState extends NewcontrolsState {}

class NewcontrolsShowState extends NewcontrolsState {}
