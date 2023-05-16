import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_state.dart';
import 'package:mod_bloc/utils/app_size.dart';

class TitleAndLoopBtnRow extends StatelessWidget {
  const TitleAndLoopBtnRow({super.key});
///this widget is row containing text widget
///which displays the name of track being played
///and a stateful builder which is an icon.
///StatefulBuilder is used for preventing whole widgtet tree rebuilt.
///StatefulBuilder widget is wrapped with Gesture Detector,
///which, on tap, toggles the state using loopBtnClicked variable
///and sets the desired release mode of the audio player
  @override
  Widget build(BuildContext context) {
    bool loopBtnClicked = false;
    ///above variable is used in toggling 
    ///the repeat icon below
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        buildWhen: (previous, current) {
      if (current is AudioPlayerLoadedState) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      if (state is AudioPlayerLoadedState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: AppSize.screenWidth / 1.245,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state.thumbnailURLs[state.passedIndex]
                      .substring(43)
                      .split(".")
                      .first,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              loopBtnClicked = !loopBtnClicked;
                              if (loopBtnClicked == true) {
                                context
                                    .read<AudioPlayerBloc>()
                                    .audioPlayer
                                    .setReleaseMode(ReleaseMode.loop);
                              } else {
                                context
                                    .read<AudioPlayerBloc>()
                                    .audioPlayer
                                    .setReleaseMode(ReleaseMode.stop);
                              }
                            });
                          },
                          child: Icon(Icons.repeat,
                              size: AppSize.screenWidth / 32,
                              color: loopBtnClicked ? Colors.red : Colors.white),
                        );
                      },
                    ))
              ],
            ),
          ),
        );
      }
      return Container();
    });
  }
}
