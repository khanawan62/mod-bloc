import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/video%20player/bloc/video_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/bloc/controls_bloc.dart';
import 'package:mod_bloc/utils/app_size.dart';
import 'package:video_player/video_player.dart';

class VideoSlider extends StatelessWidget {
  final VideoPlayerController controller;
  const VideoSlider({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    final VideoBloc videoBloc = context.read<VideoBloc>();
    final ControlsBloc controlsBloc = context.read<ControlsBloc>();
    return SizedBox(
      width: AppSize.screenWidth * 0.98,
      child: Slider.adaptive(
        min: 0.0,
        activeColor: Colors.red,
        inactiveColor: Colors.white,
        value: videoBloc.currentPosition,
        max: videoBloc.totalDuration,
        onChangeStart: (value) {
          videoBloc.add(VideoPausePressed());
          context.read<ControlsBloc>().add(ControlsHideAfterDelayPressed());
        },
        onChanged: (double value) {
          videoBloc.add(VideoSeekToPressed(seconds: value.toInt()));
          controlsBloc.add(ControlsHideAfterDelayPressed());
        },
        onChangeEnd: (double value) {
          videoBloc.add(VideoPlayPressed());
          controlsBloc.add(ControlsHideAfterDelayPressed());
        },
      ),
    );
  }
}
