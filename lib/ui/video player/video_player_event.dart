import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class VideoPlayerEvent extends Equatable {}

class Init extends VideoPlayerEvent {
  List<String> thumbnails;
  ///above thumbnails will be converted to mp4
  ///extension to load the videos
  int passedIndex;
  Init({required this.thumbnails, required this.passedIndex});
  @override
  List<Object?> get props => [thumbnails, passedIndex];
}

class PressedPause extends VideoPlayerEvent {
  @override
  List<Object?> get props => [];
}

class PressedPlay extends VideoPlayerEvent {
  @override
  List<Object?> get props => [];
}

class PressedNext extends VideoPlayerEvent {
  @override
  List<Object?> get props => [];
}

class PressedPrevious extends VideoPlayerEvent {
  @override
  List<Object?> get props => [];
}
class PressedTenSecondsForward extends VideoPlayerEvent {
  AnimationController rotationControllerForTenSecForward;
  PressedTenSecondsForward ({required this.rotationControllerForTenSecForward});
  @override
  List<Object?> get props => [rotationControllerForTenSecForward];
}
class PressedTenSecondsBackward extends VideoPlayerEvent {
  AnimationController rotationControllerForTenSecBackward;
  PressedTenSecondsBackward ({required this.rotationControllerForTenSecBackward});
  @override
  List<Object?> get props => [rotationControllerForTenSecBackward];
}
