import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_state.dart';

import '../../utils/network_constants.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  ///this class is not needed and should be deleted
  AudioPlayerCubit() : super(AudioPlayerInitState());
  bool pausePressed = false; //not using it rn
  final AudioPlayer _audioplayer = AudioPlayer();

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

  void setThumbnailsAndPassedIndex(List<String> thumbnails, int passedIndex) {
    ///this function is called at/in thumbnails screen
    ///and sets the thumbnail urls (with image extensions)
    ///using string methods and concatenation, we fill _urlSourceList with
    ///complete urls to play the audio files
    emit(AudioPlayerLoadingState());
    for (String i in thumbnails) {
      _urlSourceList.add(
          "${Constants.audioBaseUrl}${i.substring(42).split(".").first}.mp3");
    }
    _passedIndex = passedIndex;
    _thumbnails = thumbnails;
    emit(AudioPlayerLoadedState(thumbnailURLs : thumbnails, passedIndex: passedIndex));
    ///emitting state above is important, otherwise
    ///song thumbnail won't load as the audio player
    ///screen is loaded
  }

  Future<void> playAudio() async {
    await _audioplayer.play(UrlSource(_urlSourceList[_passedIndex]));
  }
  Future<void> pauseAudio() async {
    await _audioplayer.pause();
    emit(AudioPlayerPauseState());
  }

  Future<void> onPressedNext() async {
    ///not only does it play the next track,
    ///it also changes the song thumbnail by
    ///emitting states
    if (_passedIndex < _urlSourceList.length - 1) {
      ///this if will guard from going list indices beyond list range
      emit(AudioPlayerLoadingState());
      _passedIndex++;
      await _audioplayer.play(UrlSource(_urlSourceList[_passedIndex]));
      emit(AudioPlayerLoadedState(thumbnailURLs : _thumbnails, passedIndex: _passedIndex));
    }
  }

  Future<void> onPressedPrevious() async {
    ///not only does it play the previous track,
    ///it also changes the song thumbnail by
    ///emitting states
    if (_passedIndex > 0) {
      ///this if will guard from going list indices less than 0
      emit(AudioPlayerLoadingState());
      _passedIndex--;
      await _audioplayer.play(UrlSource(_urlSourceList[_passedIndex]));
      emit(AudioPlayerLoadedState(thumbnailURLs : _thumbnails, passedIndex: _passedIndex));
    }
  }

  Future<void> exitPlayer() async {
    await _audioplayer.stop();

    ///calling dispose above will cause problems
    ///you won't be able to play other tracks
    _urlSourceList.clear();
    _passedIndex = 0;

    ///as the above two variables are not the state variables
    ///we can't reset them as emit (AudioPlayerInitState())
    ///they should be manually get reset
  }
  @override
  void onChange(Change<AudioPlayerState> change) {
    //print (change);
    super.onChange(change);
  }
}
