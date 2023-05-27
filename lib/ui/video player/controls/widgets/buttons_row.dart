import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/ui/video%20player/bloc/video_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/bloc/controls_bloc.dart';
import 'package:video_player/video_player.dart';
import '../../../../utils/constants/app_size.dart';

class ButtonsRow extends StatefulWidget {
  ///this widget is a row containg play, pause,
  ///next, previous, seek video to 10 seconds
  ///forward and backward.
  ///If we don't provide video controller, then
  ///we won't be able to show spinner when
  ///a video is loading or buffering or be able
  ///to toggle the play pause buttons
  final VideoPlayerController controller;
  const ButtonsRow({super.key, required this.controller});

  @override
  State<ButtonsRow> createState() => _ButtonsRowState();
}

class _ButtonsRowState extends State<ButtonsRow> with TickerProviderStateMixin {
  ///We are using the TickerProviderStateMixin for
  ///the animation of the 10 secnds forward and backward
  ///buttons
  late AnimationController rotationControllerForTenSecForward;
  late AnimationController rotationControllerForTenSecBack;
  late final ControlsBloc _controlsBloc = context.read<ControlsBloc>();
  late final VideoBloc _videoBloc = context.read<VideoBloc>();

  @override
  void initState() {
    rotationControllerForTenSecForward = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    rotationControllerForTenSecBack = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: AppSize.screenWidth / 1.25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _videoBloc.add(Video10SecondsBackwardPressed());
                _controlsBloc.add(ControlsHideAfterDelayPressed());
                rotationControllerForTenSecBack.fling();
                Timer(const Duration(milliseconds: 200), () {
                  rotationControllerForTenSecBack.reverse();
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: -0.40)
                        .animate(rotationControllerForTenSecBack),
                    child: const Icon(
                      LineIcons.alternateUndo,
                      size: 70,
                      color: Colors.white,
                      semanticLabel: "10",
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "10",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _videoBloc.add(VideoPlayPreviousPressed());
                _controlsBloc.add(ControlsHideAfterDelayPressed());
              },
              child: Icon(Icons.skip_previous,
                  size: AppSize.screenWidth / 32, color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                _controlsBloc.add(ControlsHideAfterDelayPressed());
                if (widget.controller.value.isPlaying) {
                  _videoBloc.add(VideoPausePressed());
                } else {
                  _videoBloc.add(VideoPlayPressed());
                }
              },
              child: widget.controller.value.isBuffering
                  ? SizedBox(
                      width: AppSize.screenWidth / 8,
                      child: const CustomSpinner())

                  ///wrapping custom spinner with SizedBox with above
                  ///width will not distort ui (buttons) when custom
                  ///spinner is shown
                  : Icon(
                      widget.controller.value.isPlaying
                          ? Icons.pause_circle_filled_outlined
                          : Icons.play_circle_fill_outlined,
                      size: AppSize.screenWidth / 8,
                      color: Colors.white,
                    ),
            ),
            GestureDetector(
              onTap: () {
                _videoBloc.add(VideoPlayNextPressed());
                _controlsBloc.add(ControlsHideAfterDelayPressed());
              },
              child: Icon(Icons.skip_next,
                  size: AppSize.screenWidth / 32, color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                _videoBloc.add(Video10SecondsForwardPressed());
                _controlsBloc.add(ControlsHideAfterDelayPressed());
                rotationControllerForTenSecForward.fling();
                Timer(const Duration(milliseconds: 200), () {
                  rotationControllerForTenSecForward.reverse();
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.40)
                        .animate(rotationControllerForTenSecForward),
                    child: const Icon(
                      LineIcons.alternateRedo,
                      size: 70,
                      color: Colors.white,
                      semanticLabel: "10",
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "10",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
