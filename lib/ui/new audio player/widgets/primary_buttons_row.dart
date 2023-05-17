import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_event.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_state.dart';
import 'package:mod_bloc/utils/app_size.dart';

import '../../audio player/audio_player_bloc.dart';

class PrimaryButtonsRow extends StatelessWidget {
  const PrimaryButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              context.read<AudioPlayerBloc>().add(OnPressedPrevious());
            },
            icon: FaIcon(FontAwesomeIcons.backwardStep,
                size: AppSize.screenWidth / 38, color: Colors.white)),
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
              if (current is AudioPlayerLoadedState ||
                  current is AudioPlayerLoadingState) {
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
                  size: AppSize.screenWidth / 10,
                  color: Colors.white,
                );
              }
              if (state is AudioPlayerPauseState) {
                return Icon(
                  Icons.play_circle_fill_rounded,
                  size: AppSize.screenWidth / 10,
                  color: Colors.white,
                );
              }
              return Icon(
                Icons.pause_circle_filled_outlined,
                size: AppSize.screenWidth / 10,
                color: Colors.white,
              );
            },
          ),
        ),
        IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              context.read<AudioPlayerBloc>().add(OnPressedNext());
            },
            icon: FaIcon(FontAwesomeIcons.forwardStep,
                size: AppSize.screenWidth / 38, color: Colors.white)),
      ],
    );
  }
}
