import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/shared/custom_app_bar.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/ui/video%20player/controls/buttons_row.dart';
import 'package:mod_bloc/ui/video%20player/controls/controls_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/controls_state.dart';
import 'package:mod_bloc/ui/video%20player/controls_and_video_player_stack.dart';
import 'package:mod_bloc/ui/video%20player/video_player_bloc.dart';
import 'package:mod_bloc/ui/video%20player/video_player_event.dart';
import 'package:mod_bloc/ui/video%20player/video_player_state.dart';
import 'package:mod_bloc/utils/app_size.dart';
import 'package:video_player/video_player.dart';

import 'controls/controls_events.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  void postFramkeCallBack() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });

    ///we need this method to show the first frame
    ///otherwise we'll get to see blank white space
    ///when a video laods.
    ///We call this function in initstate, while next button is pressed
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
    postFramkeCallBack();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<VideoPlayerBloc>().videoPlayerController.dispose();
        return true;
      },
      child: GestureDetector(
        onTap: () {
          context.read<ControlsBloc>().add(ToggleControlsRightAway());
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: const CustomAppBar(
            title: "video player",
          ),
          body: SizedBox(
            height: AppSize.screenHeight,
            width: AppSize.screenWidth,
            child: BlocConsumer<VideoPlayerBloc, VideoPlayerState>(
                builder: (context, state) {
                  VideoPlayerState myState = state;
              if (state is FirstFrameState) {
                return state.videoPlayerController.value.isInitialized == false
                    ? const CustomSpinner()
                    : ControlsAndVideoPlayerStack(
                        controller: state.videoPlayerController);
              }
              if (state is VideoPlayerLoadedState) {
                return state.videoPlayerController.value.isInitialized == false
                    ? const CustomSpinner()
                    : ControlsAndVideoPlayerStack(
                        controller: state.videoPlayerController);
              }
             
              return const CustomSpinner();
            }, listener: (context, state) {
              print(state.toString());
            }),
          ),
        ),
      ),
    );
  }
}
