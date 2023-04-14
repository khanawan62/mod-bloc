import 'package:equatable/equatable.dart';

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
