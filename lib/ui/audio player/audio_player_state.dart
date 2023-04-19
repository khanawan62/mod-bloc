import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class AudioPlayerState extends Equatable {}

class AudioPlayerInitState extends AudioPlayerState {
  @override
  List<Object?> get props => [];
}

class AudioPlayerLoadingState extends AudioPlayerState {
  @override
  List<Object?> get props => [];
}
@immutable
class AudioPlayerLoadedState extends AudioPlayerState {
  final List<String> thumbnailURLs;
  final int passedIndex;
  ///above two variables are used in showing
  ///song thumbnails and are used in song_thumbnail file
  AudioPlayerLoadedState({required this.thumbnailURLs, required this.passedIndex});

  @override
  List<Object?> get props => [thumbnailURLs, passedIndex];
}

class AudioPlayerPlayingState extends AudioPlayerState {
  ///this state class is introduced only to 
  ///toggle play pause button
  @override
  List<Object?> get props => [];
}
class AudioPlayerPauseState extends AudioPlayerState {
  ///this state class is introduced only to 
  ///toggle play pause button
  @override
  List<Object?> get props => [];
}

