import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'controls.dart';

class VideoAndControlsStack extends StatelessWidget {
  final VideoPlayerController controller;
  const VideoAndControlsStack({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [VideoPlayer(controller), Controls(controller: controller)],
    );
  }
}
