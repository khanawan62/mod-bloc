import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/network_constants.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final List<String> _videoUrls = [];

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
    emit(VideoTimeUpdate(controller: _videoPlayerController));
  }

  initializeController() {
    emit(VideoLoading());
    _videoPlayerController =
        VideoPlayerController.network(_videoUrls[_passedIndex])
          ..initialize().then((_) {
            emit(VideoLoaded(controller: _videoPlayerController));
          })
          ..addListener(() {
            ///if we don't add listener here, like we have here,
            ///managing video player state becomes extremly hard
            if (_videoPlayerController.value.hasError) {
              ///you have to catch error
              ///before initialization occurs.
              ///This is why this this bloc is written here
              emit(VideoError());
            }
            if (_videoPlayerController.value.isInitialized) {
              ///without the above if, we won't be able
              ///to show spinner while the controller is being intialized.
              ///Video states also need to be emitted from within this if block
              if (_videoPlayerController.value.isPlaying) {
                emit(VideoPlaying(controller: _videoPlayerController));
              } else {
                emit(VideoPaused(controller: _videoPlayerController));
              }
              if (_videoPlayerController.value.isBuffering) {
                emit(VideoBuffering(controller: _videoPlayerController));
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

  autoLoadNextVideo() {
    ///can also be used when play next is pressed
    if (_passedIndex < _videoUrls.length - 1) {
      _passedIndex++;
      initializeController();
      _videoPlayerController.play();
    }
  }

  void releaseResources() {
    _passedIndex = 0;
    _videoUrls.clear();
    _videoPlayerController.dispose();

    ///not calling this function while going
    ///back from the video player screen, will
    ///make the system play old videos, even if
    ///we request different genre videos
  }

  VideoBloc() : super(VideoInitial()) {
    on<VideoInitPressed>((event, emit) {
      _passedIndex = event.passedIndex;
      for (String i in event.thumbnailUrls) {
        _videoUrls.add(
            "${Constants.videoBaseUrl}${i.substring(Constants.stringCutterNumber).split(".").first}.mp4");
      }
      initializeController();
      playVideo();
    });

    on<VideoPlayPressed>((event, emit) {
      playVideo();
    });

    on<VideoPausePressed>((event, emit) {
      _videoPlayerController.pause();
    });

    on<VideoPlayNextPressed>((event, emit) {
      autoLoadNextVideo();
    });

    on<VideoPlayPreviousPressed>((event, emit) {
      if (_passedIndex > 0) {
        _passedIndex--;
        initializeController();
        _videoPlayerController.play();
      }
    });

    on<VideoSeekToPressed>((event, emit) {
      _videoPlayerController.seekTo(Duration(seconds: event.seconds));
    });

    on<Video10SecondsForwardPressed>((event, emit) {
      _videoPlayerController.seekTo(
          _videoPlayerController.value.position + const Duration(seconds: 10));
    });

    on<Video10SecondsBackwardPressed>((event, emit) {
      _videoPlayerController.seekTo(
          _videoPlayerController.value.position - const Duration(seconds: 10));
    });
  }
}
