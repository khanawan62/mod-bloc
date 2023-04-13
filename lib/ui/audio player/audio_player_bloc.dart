import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_event.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_state.dart';

import '../../utils/network_constants.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer _audioplayer = AudioPlayer();
  // late StreamSubscription _streamSubscription;
  late Duration currentTime;
  List<String> _thumbnails = [];

  ///_thumbnails list is needed
  ///as it is called in onPressedNext
  ///and is passed (emitted) to AudioPlayerLoadedState
  ///to change the thumbnail of the song accordingly
  final List<String> _urlSourceList = [];

  ///_urlSourceList is filled with song urls
  ///image extensions are replaced with mp3 extension
  ///using different string methods
  int _passedIndex = 0;

  ///_passedIndex is needed
  ///as it is called in onPressedNext
  ///and is passed (emitted) to AudioPlayerLoadedState
  ///to change the thumbnail of the song accordingly

  AudioPlayerBloc() : super(AudioPlayerInitState()) {
    on<OnInitEvent>((event, emit) {
      ///this function is called/invoked at/in thumbnails screen
      ///and sets the thumbnail urls (with image extensions)
      ///using string methods and concatenation, we fill _urlSourceList with
      ///complete urls to play the audio files
      emit(AudioPlayerPlayingState());

      ///without the above line, play pause
      ///button will take time to get built on audio player screen
      emit(AudioPlayerLoadingState());
      for (String i in event.thumbnails) {
        _urlSourceList.add(
            "${Constants.audioBaseUrl}${i.substring(42).split(".").first}.mp3");
      }
      _passedIndex = event.passedIndex;
      _thumbnails = event.thumbnails;
      emit(AudioPlayerLoadedState(
          thumbnailURLs: event.thumbnails, passedIndex: event.passedIndex));
    });

    on<OnPressedPlay>((event, emit) async {
      await _audioplayer.play(UrlSource(_urlSourceList[_passedIndex]));
      emit(AudioPlayerPlayingState());

      ///above line will help toggle
      ///the play pause button
    });
    on<OnPressedPause>((event, emit) async {
      await _audioplayer.pause();
      emit(AudioPlayerPauseState());

      ///above line will help toggle
      ///the play pause button
    });

    on<OnPressedNext>((event, emit) async {
      ///not only does it play the next track,
      ///it also changes the song thumbnail by
      ///emitting states
      if (_passedIndex < _urlSourceList.length - 1) {
        ///this if will guard from going list indices beyond list range
        emit(AudioPlayerLoadingState());
        _passedIndex++;
        await _audioplayer.play(UrlSource(_urlSourceList[_passedIndex]));
        emit(AudioPlayerLoadedState(
            thumbnailURLs: _thumbnails, passedIndex: _passedIndex));
        emit(AudioPlayerPlayingState());
      }
    });
    on<OnPressedPrevious>((event, emit) async {
      ///not only does it play the previous track,
      ///it also changes the song thumbnail by
      ///emitting states
      if (_passedIndex > 0) {
        ///this if will guard from going list indices less than 0
        emit(AudioPlayerLoadingState());
        _passedIndex--;
        await _audioplayer.play(UrlSource(_urlSourceList[_passedIndex]));
        emit(AudioPlayerLoadedState(
            thumbnailURLs: _thumbnails, passedIndex: _passedIndex));
        emit(
            AudioPlayerPauseState()); //this emission will make play button to pause
        emit(AudioPlayerPlayingState());
      }
    });

    on<OnPressedExit>((event, emit) async {
      await _audioplayer.stop();

      ///calling dispose above will cause problems
      ///you won't be able to play other tracks
      _urlSourceList.clear();
      _passedIndex = 0;

      ///as the above two variables are not the state variables
      ///we can't reset them as emit (AudioPlayerInitState())
      ///they should be manually get reset
    });
  }
   Stream<Duration> getCurrentTimeStream() {
    return _audioplayer.onPositionChanged;
  }
  Stream<Duration> getTrackTotalLen() {
    return _audioplayer.onDurationChanged;
  }
}
