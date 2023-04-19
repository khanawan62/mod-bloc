import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:mod_bloc/ui/video%20player/controls/buttons_row.dart';
import 'package:mod_bloc/ui/video%20player/test_control.dart';
import 'package:video_player/video_player.dart';

class ControlsAndVideoPlayerStack extends StatelessWidget {
   VideoPlayerController controller;
  ControlsAndVideoPlayerStack({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        VideoPlayer(controller),
       // ButtonsRow(controller: controller,)
      TestControl(controller: controller)
      ],
    );
  }
}