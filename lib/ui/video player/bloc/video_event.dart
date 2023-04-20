part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class VideoInitPressed extends VideoEvent {
  ///this event is invoked at thumbnails screen
  ///and delivers the thumbnail url to be coverted to
  ///video urls in the video bloc
  final List<String> thumbnailUrls;
  final int passedIndex;
  const VideoInitPressed(
      {required this.thumbnailUrls, required this.passedIndex});
}

class VideoPlayPressed extends VideoEvent {}

class VideoPausePressed extends VideoEvent {}

class VideoPlayNextPressed extends VideoEvent {}

class VideoPlayPreviousPressed extends VideoEvent {}

class VideoSeekToPressed extends VideoEvent {
  final int seconds;
  const VideoSeekToPressed ({required this.seconds});
}

class Video10SecondsForwardPressed extends VideoEvent {}

class Video10SecondsBackwardPressed extends VideoEvent {}
