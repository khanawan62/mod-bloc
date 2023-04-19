import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/test%20video%20player/bloc/newcontrols_bloc.dart';
import 'package:mod_bloc/ui/test%20video%20player/test_buttons_row.dart';
import 'package:mod_bloc/ui/test%20video%20player/timers_row.dart';
import 'package:video_player/video_player.dart';

import 'bloc/new_test_slider.dart';

class Controls extends StatelessWidget {
  final VideoPlayerController controller;
  const Controls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<NewcontrolsBloc, NewcontrolsState>(
        builder: (context, state) {
      if (state is NewcontrolsHideState) {
        return const SizedBox();
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          TestButton(controller: controller),
          const Spacer(),
          TimersRow(controller: controller),
          NewTestSlider(controller: controller),
          const SizedBox(height: 20)
        ],
      );
    });
  }
}
