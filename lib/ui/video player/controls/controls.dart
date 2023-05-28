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
      if (state is ControlsShown) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Container(
            color: Colors.black26,
            key: const Key("showing"),
            ///when the controls are shown,
            ///the background color is slightly
            ///set to black color to make the
            ///white controls look more visible
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                const SizedBox(height: 50),
                ButtonsRow(controller: controller),
                const Spacer(),
                TimersRow(controller: controller),
                VideoSlider(controller: controller),
                const SizedBox(height: 50)
              ],
            ),
          ),
        );
      }
      return const AnimatedSwitcher(
          duration: Duration(milliseconds: 300), child: SizedBox(
            key:  Key("hiding"),
            //without this key, animation won't work
            height: double.infinity,
            width: double.infinity,
          ));
    });
  }
}
