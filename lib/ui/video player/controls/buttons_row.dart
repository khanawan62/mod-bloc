import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/ui/video%20player/controls/controls_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/controls_events.dart';
import 'package:mod_bloc/ui/video%20player/controls/controls_state.dart';
import 'package:mod_bloc/ui/video%20player/video_player_bloc.dart';
import 'package:mod_bloc/ui/video%20player/video_player_event.dart';
import 'package:mod_bloc/ui/video%20player/video_player_screen.dart';
import 'package:mod_bloc/ui/video%20player/video_player_state.dart';
import 'package:mod_bloc/utils/app_size.dart';
import 'package:video_player/video_player.dart';

class ButtonsRow extends StatefulWidget {
  final VideoPlayerController controller;
  const ButtonsRow({super.key, required this.controller});

  @override
  State<ButtonsRow> createState() => _ButtonsRowState();
}

class _ButtonsRowState extends State<ButtonsRow> with TickerProviderStateMixin {
  late AnimationController rotationControllerForTenSecForward;
  late AnimationController rotationControllerForTenSecBack;
  late VideoPlayerBloc _videoPlayerBloc;
  //late VideoPlayerController _controller;
  late ControlsBloc _controlsBloc;

  void postFramkeCallBack() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });

    ///we need this method to show the first frame
    ///otherwise we'll get to see blank white space
    ///when a video laods.
    ///We call this function at when next button is pressed
    ///and the previous button is pressed
    ///adding the postFrameCallback
    ///will do the same thing as the code given below
    ///_controller = VideoPlayerController.network(
    ///   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    /// ..initialize().then((_) {
    /// Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    ///   setState(() {});
    /// })
  }

  @override
  void initState() {
    rotationControllerForTenSecForward = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    rotationControllerForTenSecBack = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _videoPlayerBloc = context.read<VideoPlayerBloc>();
    _controlsBloc = context.read<ControlsBloc>();
    //_controller = context.read<VideoPlayerBloc>().videoPlayerController;
    super.initState();
  }

  bool isVideoPlaying = true;
  ///to toggle the play pause button

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlsBloc, ControlsState>(
      builder: (context, state) {
        if (state is HideControls) {
          return const SizedBox();
        }
        if (state is ShowControls) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: AppSize.screenWidth / 1.25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _videoPlayerBloc.add(PressedTenSecondsBackward(rotationControllerForTenSecBackward: rotationControllerForTenSecBack));
                  _controlsBloc.add(HideControlsAfterDelay());
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
                 _videoPlayerBloc.add(PressedPrevious());
                  postFramkeCallBack();
                  _controlsBloc.add(HideControlsAfterDelay());
                },
                child: Icon(Icons.skip_previous,
                    size: AppSize.screenWidth / 32, color: Colors.white),
              ),
              context.read<VideoPlayerBloc>().videoPlayerController.value.isBuffering ? const CustomSpinner() : 
              StatefulBuilder(builder: (context, setState) {
                return GestureDetector(
                  onTap: () {
                    setState((() {
                      isVideoPlaying = !isVideoPlaying;
                      if (widget.controller.value.isPlaying) { 
                        _videoPlayerBloc.add(PressedPause());
                      } else {
                        _videoPlayerBloc.add(PressedPlay());
                      }
                      _controlsBloc.add(HideControlsAfterDelay());
                    }));
                  },
                  child: Icon(
                    !isVideoPlaying
                        ? Icons.play_circle_fill_outlined
                        : Icons.pause_circle_filled_outlined,
                    size: AppSize.screenWidth / 8,
                    color: Colors.white,
                  ),
                );
              }), 
              GestureDetector(
                onTap: () {
                  _videoPlayerBloc.add(PressedNext());
                  postFramkeCallBack();
                  _controlsBloc.add(HideControlsAfterDelay());
                },
                child: Icon(Icons.skip_next,
                    size: AppSize.screenWidth / 32, color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  // _controlsBloc.emit(HideControls());
                  // _controlsBloc.emit(ShowControls());
                  _videoPlayerBloc.add(PressedTenSecondsForward(rotationControllerForTenSecForward: rotationControllerForTenSecForward));
                  _controlsBloc.add(HideControlsAfterDelay());
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
      return Text("no state found");
    });
  }
}
