import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/constants/network_constants.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  
  String get fileName =>
      _videoUrls[_passedIndex].substring(32).split(".mp4").first;

  ///above getter will be used to
  ///display the name of the currently played
  ///video inside the video_player_appbar widget
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

  ///above controller will be passed to the state
  ///and the ui will make use of this passed controller
  ///in doing different (desired) things
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

  int _maxBuffering = 0;
  ///this variable will be used in value property of slider widget's
  ///LinearProgressIndicator to show buffering progress
  int get maxBuffering => _maxBuffering;
  getBufferingProgress() {
    ///this method will be called inside the build
    ///method of video_slider widget
    for (final DurationRange range in _videoPlayerController.value.buffered) {
      final int end = range.end.inSeconds;
      if (end > _maxBuffering) {
        _maxBuffering = end;
      }
    }
    ///this code (method) was taken from exploring the video player package
    ///I don't know how this code works
    ///But it will give the video buffering progress
  }

  initializeController() {
    _maxBuffering = 0;
    ///above variable needs to set to 0 here
    ///otherwise newly loaded video will
    ///have previous video's buffering progress
    emit(VideoLoading());

    ///above line will help show spinner
    ///when the controller is getting intitialized
    _videoPlayerController =
        VideoPlayerController.network(_videoUrls[_passedIndex])
          ..initialize().then((_) {
            _videoPlayerController.play();
            emit(VideoLoaded(controller: _videoPlayerController));

            ///above line will help stop the rotating spinner
            ///when the controller was getting intitialized
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
              ///i.e once the controller is intialized
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
    ///method can also be used when play next is pressed
    if (_passedIndex < _videoUrls.length - 1) {
      _passedIndex++;
      onControllerChange();
    }
  }

  Future<void> onControllerChange() async {
    ///this is the method to get rid of exo player error
    ///which comes when you load 4-5 videos in a row and play
    ///a video which was previosuly played.
    ///Call this method on playing next or
    ///previous video
    if (_videoPlayerController == null) {
      initializeController();
    } else {
      final oldController = _videoPlayerController;
      await oldController.dispose();
      initializeController();
    }
  }

  void releaseResources() async {
    _passedIndex = 0;
    _videoUrls.clear();
    await _videoPlayerController.dispose();

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
        onControllerChange();
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
