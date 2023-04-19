import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class ControlsState extends Equatable {}

class InitControlsState extends ControlsState {
  @override
  List<Object?> get props => [];
}

class ShowControls extends ControlsState {
  @override
  List<Object?> get props => [];
}

class HideControls extends ControlsState {
  @override
  List<Object?> get props => [];
}
class PausedState extends ControlsState {
  @override
  List<Object?> get props => [];
}
