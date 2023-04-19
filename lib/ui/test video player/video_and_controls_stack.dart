import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'controls.dart';

class VideoAndControlsStack extends StatelessWidget {
  final VideoPlayerController controller;
  ///above controller will be provided
  ///to the VideoPlayer (plugin provided widget)
  ///to play the video.
  ///Controller will also be passed to controls as well
  const VideoAndControlsStack({super.key, required this.controller});
  ///this widget is a stack having
  ///video player (provided by the video player plugin)
  ///and a widget developed by me named 'controls'

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [VideoPlayer(controller), Controls(controller: controller)],
    );
  }
}
