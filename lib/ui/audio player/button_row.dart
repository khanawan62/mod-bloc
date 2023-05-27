import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_event.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_state.dart';
import 'package:mod_bloc/utils/constants/app_size.dart';

import 'audio_player_bloc.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: AppSize.screenWidth / 1.245,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  context.read<AudioPlayerBloc>().add(OnPressedPrevious());
                },
                child: Icon(Icons.skip_previous,
                    size: AppSize.screenWidth / 32, color: Colors.white)),
            GestureDetector(
              onTap: () {
                if (context.read<AudioPlayerBloc>().state
                    is AudioPlayerPlayingState) {
                  context.read<AudioPlayerBloc>().add(OnPressedPause());
                } else {
                  context.read<AudioPlayerBloc>().add(OnPressedPlay());
                }
              },
              child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                buildWhen: (previous, current) {
                  if (current is AudioPlayerLoadedState || current is AudioPlayerLoadingState) {
                    return false;
                  }
                  ///above if condition will guard unwanted
                  ///rebuild of the play pause button
                  ///alongwith emit (AudioPlayerPlaying) in
                  ///onPressedNext event
                  return true;
                },
                builder: (context, state) {
                  if (state is AudioPlayerPlayingState) {
                    return Icon(
                      Icons.pause_circle_filled_outlined,
                      size: AppSize.screenWidth / 8,
                      color: Colors.white,
                    );
                  } 
                  if (state is AudioPlayerPauseState) {
                  return Icon(
                    Icons.play_circle_filled_outlined,
                    size: AppSize.screenWidth / 8,
                    color: Colors.white,
                  );
                  }
                  return  Icon(
                      Icons.pause_circle_filled_outlined,
                      size: AppSize.screenWidth / 8,
                      color: Colors.white,
                    );
                },
              ),
            ),
            GestureDetector(
                onTap: () {
                  context.read<AudioPlayerBloc>().add(OnPressedNext());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.skip_next,
                      size: AppSize.screenWidth / 32, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
