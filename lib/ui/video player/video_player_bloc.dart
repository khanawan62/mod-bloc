import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/video%20player/video_player_event.dart';
import 'package:mod_bloc/ui/video%20player/video_player_state.dart';
import 'package:video_player/video_player.dart';

import '../../utils/network_constants.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  final List<String> _urlSourceList = [];
  ///_urlSourceList is filled with video urls
  ///image extensions are replaced with mp4 extension
  ///by using different string methods
  ///inside OnInitEvent
  int _passedIndex = 0;
  ///this is being set by 'OnInitEvent' and
  ///used in loading next video by incrementing it
  ///and previous video by decrementing it
  late VideoPlayerController _videoPlayerController;
  VideoPlayerController get videoPlayerController => _videoPlayerController;
  ///above getter of the controller is needed
  ///as we have to dispose the video controller
  ///on going back from the video player screen

  initializeController() {
    _videoPlayerController = VideoPlayerController.network(
        _urlSourceList[_passedIndex])
      ..initialize().then((_) {
        emit(FirstFrameState(videoPlayerController: _videoPlayerController));
        ///without emiting this FirstFrame state,
        ///we won't be able to show starting frames
        ///and we will get to see a blank white space instead
      });
  }

  Future<void> playVideo() async {
    await _videoPlayerController.play();
  }

  void initThenPlayThenEmitLoadedState() {
    ///this method first intiaizes the controller
    ///and plays the video and emit the VideoPlayerLoaded
    ///state.
    ///As the code for doing these 3 operations is commonly needed/used,
    ///this is why this function is created
    emit(VideoPlayerLoadingState());
    initializeController();
    playVideo();
    emit(VideoPlayerLoadedState(
        passedIndex: _passedIndex,
        videoPlayerController: _videoPlayerController));
  }

  VideoPlayerBloc() : super(VideoPlayerInitState()) {
    on<Init>((event, emit) {
      ///this function is called/invoked at/in thumbnails screen
      ///and recives thumbnail urls (with image extensions) and passed index,
      ///that we can get with event.thumbnails and event.passed respectively.
      ///Using string methods and concatenation, we fill _urlSourceList with
      ///complete urls to play the video files
      
      // emit(VideoPlayerLoadingState());
      for (String i in event.thumbnails) {
        _urlSourceList.add(
            "${Constants.videoBaseUrl}${i.substring(42).split(".").first}.mp4");
      }
      _passedIndex = event.passedIndex;
      initThenPlayThenEmitLoadedState();
    });

    on<PressedNext>((event, emit) {
      _passedIndex++;
      initThenPlayThenEmitLoadedState();
    });
  }
  @override
  void onTransition(Transition<VideoPlayerEvent, VideoPlayerState> transition) {
    print (transition);
    super.onTransition(transition);
  }
}
