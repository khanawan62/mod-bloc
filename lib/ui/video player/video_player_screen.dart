import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/video%20player/bloc/video_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/bloc/controls_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/widgets/video_player_appbar.dart';
import 'package:mod_bloc/utils/app_size.dart';
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
              child:
                  BlocBuilder<VideoBloc, VideoState>(builder: (context, state) {
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
