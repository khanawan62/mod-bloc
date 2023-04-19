import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/video%20player/video_player_bloc.dart';
import 'package:mod_bloc/ui/video%20player/video_player_event.dart';
import 'package:mod_bloc/ui/video%20player/video_player_state.dart';
import 'package:video_player/video_player.dart';

import '../../utils/app_size.dart';

class TestControl extends StatefulWidget {
  VideoPlayerController controller;
  TestControl({super.key, required this.controller});

  @override
  State<TestControl> createState() => _TestControlState();
}

class _TestControlState extends State<TestControl> {
  late VideoPlayerBloc _videoPlayerBloc;
  late VideoPlayerController _controller;
  @override
  void initState() {
    _videoPlayerBloc = context.read<VideoPlayerBloc>();
    _controller = _videoPlayerBloc.videoPlayerController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.controller.value.isPlaying) {
          _videoPlayerBloc.add(PressedPause());
          _videoPlayerBloc.emit(VideoPlayerInitState ());
        } else {
          _videoPlayerBloc.add(PressedPlay());
        }
      },
      child: Icon(
        !widget.controller.value.isPlaying
            ? Icons.play_circle_fill_outlined
            : Icons.pause_circle_filled_outlined,
        size: AppSize.screenWidth / 8,
        color: Colors.white,
      ),
    );
  }
}
