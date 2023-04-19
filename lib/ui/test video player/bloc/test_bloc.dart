import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/network_constants.dart';
part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final List <String> _videoUrls = [];
  ///we'd recieve the thumbnail urls
  ///from the inititial bloc event, which is invoked at the thumbnails screen.
  ///We'll loop through the recieved thumbnail list and replace the 
  ///image extensions with mp4 extension and add the video urls to 
  ///the above list
  int _passedIndex = 0;
  ///Recieved from the initial bloc event
  late VideoPlayerController _videoPlayerController;
  VideoPlayerController get videoPlayerController => _videoPlayerController;
  double currentPosition = 0;
  double totalDuration = 0;
  ///above two double variables are 
  ///used in slider widget and they are also
  ///used in auto loading the next video and they 
  ///get their values from _videoPlayerController.value.position and duration
  ///respectively

  updateTimes() {
    ///if we don't emit the below state,
    ///the timers won't be updated
    emit(TestUpdateTimesState(controller: _videoPlayerController));

  }

  initializeController() {
    emit(TestLoadingState());
    _videoPlayerController = VideoPlayerController.network(_videoUrls[_passedIndex])
      ..initialize().then((_) {
        emit(TestLoadedState(controller: _videoPlayerController));
      })
      ..addListener(() {
        ///if we don't add listener here, like we have here,
        ///managing video player state becomes extremly hard
        if (_videoPlayerController.value.hasError) {
          ///you have to catch error 
          ///before initialization occurs.
          ///This is why this this bloc is written here
            emit(TestErrorState(errorMsg: _videoPlayerController.value.errorDescription.toString()));
          }
        if (_videoPlayerController.value.isInitialized) {
          ///without the above if, we won't be able
          ///to show spinner while the controller is being intialized.
          ///Video states also need to be emitted from within this if block
          if (_videoPlayerController.value.isPlaying) {
            emit(TestPlayingState(controller: _videoPlayerController));
          } else {
            emit(TestPausedState(controller: _videoPlayerController));
          }
          if (_videoPlayerController.value.isBuffering) {
           emit(TestBufferingState(controller: _videoPlayerController));
          }
          currentPosition =
              _videoPlayerController.value.position.inSeconds.toDouble();
          totalDuration =
              _videoPlayerController.value.duration.inSeconds.toDouble();
              updateTimes();
          if (currentPosition == totalDuration) {
            autoLoadNextVideo();
          }
        }
      });
  }

  playVideo() {
    _videoPlayerController.play();
  }

  TestBloc() : super(TestInitialState()) {
    on<TestInitEvent>((event, emit) {
      _passedIndex = event.passedIndex;
      for (String i in event.thumbnailUrls) {
        _videoUrls.add(
            "${Constants.videoBaseUrl}${i.substring(Constants.stringCutterNumber).split(".").first}.mp4");
      }
      initializeController();
      playVideo();
    });

    on<TestPausedEvent>((event, emit) {
      _videoPlayerController.pause();
    });

    on<TestPlayEvent>((event, emit) {
      playVideo();
    });
    on<TestMoveEvent>((event, emit) {
      _videoPlayerController.seekTo(
          _videoPlayerController.value.position + const Duration(seconds: 10));
    });
    on<TestNextEvent>((event, emit) {
      _passedIndex++;
      initializeController();
      _videoPlayerController.play();
    });
  }

  autoLoadNextVideo() {
    _passedIndex++;
    initializeController();
    _videoPlayerController.play();
  }

  @override
  void onTransition(Transition<TestEvent, TestState> transition) {
    print(transition);
    super.onTransition(transition);
  }
  void releaseResources () {
    _passedIndex = 0;
    _videoUrls.clear();
    _videoPlayerController.dispose();
    ///not calling this function while going 
    ///back from the video player screen, will
    ///make the system play old videos, even if 
    ///we request different genre videos
  }
}
