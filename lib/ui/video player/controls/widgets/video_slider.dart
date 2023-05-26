import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/video%20player/bloc/video_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/bloc/controls_bloc.dart';
import 'package:mod_bloc/utils/app_size.dart';
import 'package:video_player/video_player.dart';

class VideoSlider extends StatelessWidget {
  final VideoPlayerController controller;
  VideoSlider({super.key, required this.controller});

  int maxBuffering = 0;

  getBufferingProgress () {
    for (final DurationRange range in controller.value.buffered) {
      final int end = range.end.inSeconds;
      if (end > maxBuffering) {
        maxBuffering = end;
      }
    }
    ///this code was taken from exploring the video player package
    ///I don't know how this code works
    ///But it will give the video buffering progress
    ///You can't take this code to bloc
    ///doing so won't work
  }
  @override
  Widget build(BuildContext context) {
    final VideoBloc videoBloc = context.read<VideoBloc>();
    final ControlsBloc controlsBloc = context.read<ControlsBloc>();
    getBufferingProgress();
    return SizedBox(
      width: AppSize.screenWidth * 0.98,
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.screenWidth / 52.244898, vertical: AppSize.screenHeight / 36.3636364),
          child: LinearProgressIndicator(
            value: maxBuffering / videoBloc.totalDuration,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade700),
            backgroundColor: Colors.white,
          ),
        ),
        SliderTheme(
            data: SliderThemeData(
              trackHeight: 1,
              ///keeping track height as small as
              ///1 will make the buffering progress (linear progress indicator)
              ///show nicely
              thumbShape: SliderComponentShape.noThumb,
            ),
            child: Slider.adaptive(
              min: 0.0,
              activeColor: Colors.red,
              inactiveColor: Colors.white,
              value: videoBloc.currentPosition,
              max: videoBloc.totalDuration,
              onChangeStart: (value) {
                videoBloc.add(VideoPausePressed());
                context
                    .read<ControlsBloc>()
                    .add(ControlsHideAfterDelayPressed());
              },
              onChanged: (double value) {
                videoBloc.add(VideoSeekToPressed(seconds: value.toInt()));
                controlsBloc.add(ControlsHideAfterDelayPressed());
              },
              onChangeEnd: (double value) {
                videoBloc.add(VideoPlayPressed());
                controlsBloc.add(ControlsHideAfterDelayPressed());
              },
            ))
      ]),
    );
  }
}
