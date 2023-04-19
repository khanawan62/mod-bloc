import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class ControlsEvent extends Equatable {}

class ToggleControlsRightAway extends ControlsEvent {
  @override
  List<Object?> get props => [];
}
class HideControlsAfterDelay extends ControlsEvent {
  @override
  List<Object?> get props => [];
}