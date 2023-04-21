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
          return BlocSelector<VideoBloc, VideoState, bool>(
              selector: (state) => state is VideoLoaded ? true : false,
              builder: (context, state) {
                return AppBar(
                  automaticallyImplyLeading: true,
                  title: Text(
                    context.read<VideoBloc>().fileName,
                    ///without using the bloc selector
                    ///we would need to used context.watch instead,
                    ///which will rebuilt the appbar whenever the controls
                    ///state is shows
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.black,
                  centerTitle: true,
                );
              });
        }
        return const SizedBox();
      },
    );
  }
}
