import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/test%20video%20player/bloc/newcontrols_bloc.dart';
import 'package:mod_bloc/ui/test%20video%20player/bloc/test_bloc.dart';
import 'package:mod_bloc/utils/app_size.dart';
import 'package:video_player/video_player.dart';

class NewTestSlider extends StatelessWidget {
  final VideoPlayerController controller;
  const NewTestSlider({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    final TestBloc testBloc = context.read <TestBloc>();
    final NewcontrolsBloc controlsBloc = context.read <NewcontrolsBloc> (); 
    return SizedBox(
      width: AppSize.screenWidth * 0.98,
      child: Slider.adaptive(
        min: 0.0,
        activeColor: Colors.red,
        inactiveColor: Colors.white,
        value: testBloc.currentPosition,
        max: testBloc.totalDuration,
        onChangeStart: (value) {
          testBloc.add(TestPausedEvent());
          context.read<NewcontrolsBloc>().add(HideNewControlsAfterDelay());
        },
        onChanged: (double value) {
          testBloc
              .videoPlayerController
              .seekTo(Duration(seconds: value.toInt()));
          controlsBloc.add(HideNewControlsAfterDelay());
        },
        onChangeEnd: (double value) {
          testBloc.add(TestPlayEvent());
          controlsBloc.add(HideNewControlsAfterDelay());
        },
      ),
    );
  }
}
