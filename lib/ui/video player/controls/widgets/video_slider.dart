import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/video%20player/bloc/video_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/bloc/controls_bloc.dart';
import 'package:mod_bloc/utils/constants/app_size.dart';
import 'package:video_player/video_player.dart';

class VideoSlider extends StatelessWidget {
  final VideoPlayerController controller;
  const VideoSlider({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final VideoBloc videoBloc = context.read<VideoBloc>();
    final ControlsBloc controlsBloc = context.read<ControlsBloc>();
    videoBloc.getBufferingProgress ();
    return SizedBox(
      width: AppSize.screenWidth * 0.98,
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.screenWidth / 52.244898,
              vertical: AppSize.screenHeight / 34.3736364),
          child: LinearProgressIndicator(
            minHeight: 1.5,
            value: videoBloc.maxBuffering / videoBloc.totalDuration,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            backgroundColor: const Color.fromRGBO(128, 128, 128, 1),
          ),
        ),
        SliderTheme(
            data: const SliderThemeData(
              trackHeight: 1.5,
              ///keeping track height as small as
              ///1 will make the buffering progress (linear progress indicator)
              ///show nicely
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
            ),
            child: Slider.adaptive(
              min: 0.0,
              activeColor: Colors.red,
              inactiveColor: const Color.fromRGBO(128, 128, 128, 1),
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
