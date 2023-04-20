part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoPlaying extends VideoState {
  final VideoPlayerController controller;
  const VideoPlaying({required this.controller});

  @override
  List<Object> get props => [controller];
}

class VideoBuffering extends VideoState {
  final VideoPlayerController controller;
  const VideoBuffering({required this.controller});

  @override
  List<Object> get props => [controller];
}

class VideoPaused extends VideoState {
  final VideoPlayerController controller;
  const VideoPaused({required this.controller});

  @override
  List<Object> get props => [controller];
}

class VideoLoading extends VideoState {}

class VideoError extends VideoState {}

class VideoLoaded extends VideoState {
  final VideoPlayerController controller;
  const VideoLoaded({required this.controller});

  @override
  List<Object> get props => [controller];
}

class VideoTimeUpdate extends VideoState {
  final VideoPlayerController controller;
  const VideoTimeUpdate({required this.controller});

  @override
  List<Object> get props => [controller];
}
