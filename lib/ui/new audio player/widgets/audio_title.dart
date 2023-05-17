import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../audio player/audio_player_bloc.dart';
import '../../audio player/audio_player_state.dart';

class AudioTitle extends StatelessWidget {
  const AudioTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      buildWhen: (previous, current) {
        if (current is AudioPlayerLoadedState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is AudioPlayerLoadedState) {
          return Text(
            state.thumbnailURLs[state.passedIndex]
                .substring(43)
                .split(".")
                .first,
            style: const TextStyle(
              height: 1.2,
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500),
          );
        }
        return Container();
      },
    );
  }
}
