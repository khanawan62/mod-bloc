import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_state.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/utils/app_size.dart';

import '../../audio player/audio_player_bloc.dart';

class AudioThumbnail extends StatelessWidget {
  const AudioThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      buildWhen: (previous, current) {
        if (current is AudioPlayerLoadedState) {
          return true;
        }
        ///above if condition will gaurd 
        ///the unwanted rebuild
        return false;
      },
        builder: (context, state) {
          if (state is AudioPlayerLoadedState ) {
            return Padding(
              padding: const EdgeInsets.only(left: 5),
              child: SizedBox(
                height: AppSize.screenHeight / 1.33,
                width: AppSize.screenWidth / 2,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child:
                          Image.network(state.thumbnailURLs[state.passedIndex], fit: BoxFit.cover,)),
                ),
              ),
            );
          }
          if (state is AudioPlayerLoadingState) {
            return SizedBox(

                ///this sized box is important
                ///without it, ui will cause problems
                ///upon loading next or previous track
                ///this sized box has the same dimension as the above image network
                ///for proper showing of spinner w/o any issues
                height: AppSize.screenHeight / 2,
                width: AppSize.screenWidth / 1.25,
                child: const Center(child: CustomSpinner()));
          }
          return const SizedBox(
            child: Text(
              "empty container",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        },
        );
  }
}
