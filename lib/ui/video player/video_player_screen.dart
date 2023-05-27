import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/video%20player/bloc/video_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/bloc/controls_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/widgets/video_player_appbar.dart';
import 'package:mod_bloc/utils/constants/app_size.dart';
import '../shared/custom_error_widget.dart';
import '../shared/custom_spinner.dart';
import 'controls/widgets/video_and_controls_stack.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  postFrame() {
    ///this methods helps build the first frame
    ///in my opionin
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void initState() {
    context.read<ControlsBloc>().add(ControlsHideAfterDelayPressed());

    postFrame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<VideoBloc>().releaseResources();
        context.read<ControlsBloc>().cancelHideTimer();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const VideoPlayerAppbar(),
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () {
            context.read<ControlsBloc>().add(ControlsToggleRightAwayPressed());
          },
          child: SizedBox(
              height: AppSize.screenHeight,
              width: AppSize.screenWidth,
              child: BlocConsumer<VideoBloc, VideoState>(
                  listener: (context, state) {
                if (state is VideoError) {
                  context.read<ControlsBloc>().cancelHideTimer();

                  ///above line will make sure that app bar of
                  ///video player doesn't hide when there's an
                  ///an error in a video
                }
              }, builder: (context, state) {
                if (state is VideoPlaying) {
                  return VideoAndControlsStack(controller: state.controller);
                }
                if (state is VideoPaused) {
                  return VideoAndControlsStack(controller: state.controller);
                }
                if (state is VideoBuffering) {
                  return VideoAndControlsStack(controller: state.controller);
                }
                if (state is VideoLoaded) {
                  return VideoAndControlsStack(controller: state.controller);
                }
                if (state is VideoTimeUpdate) {
                  return VideoAndControlsStack(controller: state.controller);
                }
                if (state is VideoError) {
                  return const CustomErrorWidget(errorMsg: "An error occured");
                }
                if (state is VideoLoading) {
                  return const CustomSpinner();
                }
                return const CustomSpinner();
              })),
        ),
      ),
    );
  }
}
