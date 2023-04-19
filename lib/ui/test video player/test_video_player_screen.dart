import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/ui/test%20video%20player/bloc/newcontrols_bloc.dart';
import 'package:mod_bloc/ui/test%20video%20player/bloc/test_bloc.dart';
import 'package:mod_bloc/ui/test%20video%20player/test_button.dart';
import 'package:mod_bloc/utils/app_size.dart';
import 'package:video_player/video_player.dart';

class TestVideoPlayerScreen extends StatefulWidget {
  const TestVideoPlayerScreen({super.key});

  @override
  State<TestVideoPlayerScreen> createState() => _TestVideoPlayerScreenState();
}

class _TestVideoPlayerScreenState extends State<TestVideoPlayerScreen> {
  postFrame() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void initState() {
    context.read<TestBloc>().add(TestInitEvent());
    context.read<NewcontrolsBloc>().add(HideNewControlsAfterDelay());
    postFrame();
    print("init called of the video player test screen");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          context.read<NewcontrolsBloc>().add(ToggleNewControlsRightAway());
        },
        child: Center(
          child: SizedBox(
              height: AppSize.screenHeight,
              width: AppSize.screenWidth,
              child:
                  BlocBuilder<TestBloc, TestState>(builder: (context, state) {
                if (state is TestPlayingState) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(state.controller),
                      TestButton(controller: state.controller)
                    ],
                  );
                }
                if (state is TestPausedState) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(state.controller),
                      TestButton(controller: state.controller)
                    ],
                  );
                }
                if (state is TestBufferingState) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(state.controller),
                      TestButton(controller: state.controller)
                    ],
                  );
                }
                if (state is TestLoadedState) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(state.controller),
                      TestButton(controller: state.controller)
                    ],
                  );
                }
                if (state is TestLoadingState) {
                  return const CustomSpinner();
                }
                return const CustomSpinner();
              })),
        ),
      ),
    );
  }
}
