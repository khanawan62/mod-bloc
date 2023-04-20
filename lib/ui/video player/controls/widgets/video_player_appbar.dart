import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/video%20player/bloc/video_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/bloc/controls_bloc.dart';

class VideoPlayerAppbar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const VideoPlayerAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlsBloc, ControlsState>(
      builder: (context, state) {
        if (state is ControlsShown) {
          return AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              context.watch <VideoBloc> ().fileName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
            centerTitle: true,
          );
        }
        return const SizedBox();
      },
    );
  }
}
