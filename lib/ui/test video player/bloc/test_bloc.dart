import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';
part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  late VideoPlayerController _videoPlayerController;
  VideoPlayerController get videoPlayerController => _videoPlayerController;
  int idx = 0;
  double currentPosition = 0;
  double totalDuration = 0;
  List<String> urls = [
    "http://192.168.100.5:3001/videos/Greenland.mp4",
    "http://192.168.100.5:3001/videos/Safety.mp4",
    "http://192.168.100.5:3001/videos/Unhinged.mp4",
  ];

  initializeController() {
    emit(TestLoadingState());
    _videoPlayerController = VideoPlayerController.network(urls[idx])
      ..initialize().then((_) {
        emit(TestLoadedState(controller: _videoPlayerController));
      })
      ..addListener(() {
        if (_videoPlayerController.value.isInitialized) {
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
      idx++;
      initializeController();
      _videoPlayerController.play();
    });
  }

  autoLoadNextVideo() {
    idx++;
    initializeController();
    _videoPlayerController.play();
  }

  @override
  void onTransition(Transition<TestEvent, TestState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
