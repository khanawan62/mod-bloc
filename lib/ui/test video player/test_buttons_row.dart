import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/ui/test%20video%20player/bloc/new_test_slider.dart';
import 'package:mod_bloc/ui/test%20video%20player/bloc/newcontrols_bloc.dart';
import 'package:mod_bloc/ui/test%20video%20player/bloc/test_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/controls_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/controls_state.dart';
import 'package:video_player/video_player.dart';
import '../../utils/app_size.dart';

class TestButton extends StatefulWidget {
  final VideoPlayerController controller;
  const TestButton({super.key, required this.controller});

  @override
  State<TestButton> createState() => _TestButtonState();
}

class _TestButtonState extends State<TestButton> with TickerProviderStateMixin {
  late AnimationController rotationControllerForTenSecForward;
  late AnimationController rotationControllerForTenSecBack;
  late final NewcontrolsBloc _controlsBloc = context.read<NewcontrolsBloc>();
  late final TestBloc _testBloc = context.read<TestBloc>();

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
              onTap: () {},
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
              onTap: () {},
              child: Icon(Icons.skip_previous,
                  size: AppSize.screenWidth / 32, color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                _controlsBloc.add(HideNewControlsAfterDelay());
                if (widget.controller.value.isPlaying) {
                  _testBloc.add(TestPausedEvent());
                } else {
                  _testBloc.add(TestPlayEvent());
                }
              },
              child: widget.controller.value.isBuffering
                  ? const CustomSpinner()
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
                _testBloc.add(TestNextEvent());
                _controlsBloc.add(HideNewControlsAfterDelay());
              },
              child: Icon(Icons.skip_next,
                  size: AppSize.screenWidth / 32, color: Colors.white),
            ),
            GestureDetector(
              onTap: () {},
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
