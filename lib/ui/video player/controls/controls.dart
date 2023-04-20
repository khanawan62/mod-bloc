import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/bloc/controls_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/widgets/buttons_row.dart';
import 'package:mod_bloc/ui/video%20player/controls/widgets/timers_row.dart';
import 'package:mod_bloc/ui/video%20player/controls/widgets/video_slider.dart';
import 'package:video_player/video_player.dart';


class Controls extends StatelessWidget {
  final VideoPlayerController controller;

  ///Controls widget doesn't need the above
  ///controller. Controller will be passed
  ///to TimersRow and Slider
  ///Controls widget is a column containing Spacers
  ///for spacing and TimersRow and ButtonsRow
  ///The whole column is wrapped with ControlsBlocBuilder
  ///to hide and show the controls
  const Controls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlsBloc, ControlsState>(builder: (context, state) {
      if (state is ControlsHidden) {
        return const SizedBox();
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          ButtonsRow(controller: controller),
          const Spacer(),
          TimersRow(controller: controller),
          VideoSlider(controller: controller),
          const SizedBox(height: 20)
        ],
      );
    });
  }
}
