import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/shared/custom_app_bar.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/ui/test%20video%20player/bloc/newcontrols_bloc.dart';
import 'package:mod_bloc/ui/test%20video%20player/bloc/test_bloc.dart';
import 'package:mod_bloc/ui/test%20video%20player/video_and_controls_stack.dart';
import 'package:mod_bloc/utils/app_size.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: "hello"),
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          context.read<NewcontrolsBloc>().add(ToggleNewControlsRightAway());
        },
        child: SizedBox(
            height: AppSize.screenHeight,
            width: AppSize.screenWidth,
            child: BlocBuilder<TestBloc, TestState>(builder: (context, state) {
              if (state is TestPlayingState) {
                return VideoAndControlsStack(controller: state.controller);
              }
              if (state is TestPausedState) {
                return VideoAndControlsStack(controller: state.controller);
              }
              if (state is TestBufferingState) {
                return VideoAndControlsStack(controller: state.controller);
              }
              if (state is TestLoadedState) {
                return VideoAndControlsStack(controller: state.controller);
              }
              if (state is TestUpdateTimesState) {
                return VideoAndControlsStack(controller: state.controller);
              }
              if (state is TestLoadingState) {
                return const CustomSpinner();
              }
              return const CustomSpinner();
            })),
      ),
    );
  }
}
