import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/video%20player/bloc/video_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/bloc/controls_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/widgets/volume_slider.dart';

class VideoPlayerAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const VideoPlayerAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlsBloc, ControlsState>(
      builder: (context, state) {
        if (state is ControlsShown) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: BlocBuilder<VideoBloc, VideoState>(
              ///animated switcher will only work in this 
              ///(inner) bloc and work in outer bloc
              key: const Key("blocKey"),
                buildWhen: (p, c) => c is VideoLoaded ? true : false,
                builder: (context, state) {
                  return AppBar(
                    actions:  const [
                      VolumeSlider()
                    ],
                    automaticallyImplyLeading: true,
                    title: Text(
                      context.read<VideoBloc>().fileName,
                      ///without using the blocbuilder's buildwhen property 
                      ///we would need to use context.watch instead,
                      ///which will rebuild the appbar whenever the controls
                      ///state is changed to shown
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.black,
                    centerTitle: true,
                  );
                }),
          );
        }
        return const AnimatedSwitcher(
          duration: Duration(milliseconds: 350),
          child: SizedBox(
            key: Key("boxKey"),
          ),
        );
      },
    );
  }
}
