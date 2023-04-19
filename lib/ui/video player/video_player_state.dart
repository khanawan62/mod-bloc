import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

@immutable
abstract class VideoPlayerState extends Equatable {}

class VideoPlayerInitState extends VideoPlayerState {
  int? passedIndex;
  VideoPlayerController? videoPlayerController;
  VideoPlayerInitState({this.passedIndex, this.videoPlayerController});
  @override
  List<Object?> get props => [passedIndex, videoPlayerController];
}

class FirstFrameState extends VideoPlayerState {
  final VideoPlayerController videoPlayerController;
  FirstFrameState({required this.videoPlayerController});
  @override
  List<Object?> get props => [videoPlayerController];
}

class VideoPlayerLoadingState extends VideoPlayerState {
  @override
  List<Object?> get props => [];
}

class VideoPlayerLoadedState extends VideoPlayerState {
  final int passedIndex;
  final VideoPlayerController videoPlayerController;
  VideoPlayerLoadedState(
      {required this.passedIndex, required this.videoPlayerController});
  @override
  List<Object?> get props => [passedIndex, videoPlayerController];
}

class VideoPlayerPlayingState extends VideoPlayerState {
  @override
  List<Object?> get props => [];
}

class VideoPlayerPausedState extends VideoPlayerState {
  @override
  List<Object?> get props => [];
}
