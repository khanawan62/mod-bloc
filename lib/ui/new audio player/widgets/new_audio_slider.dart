import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_event.dart';
import 'package:mod_bloc/utils/constants/app_size.dart';
import '../../audio player/audio_player_bloc.dart';

class NewAudioSlider extends StatelessWidget {
  const NewAudioSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.screenWidth / 5.2,
      child: StreamBuilder<Duration>(
        stream: context.read<AudioPlayerBloc>().getCurrentTimeStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return SliderTheme(
              data: SliderThemeData(
                  trackHeight: 1,
                  overlayShape: SliderComponentShape.noThumb,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 7)),
              child: Slider.adaptive(
                min: 0.0,
                activeColor: Colors.red,
                inactiveColor: Colors.white,
                value: snapshot.data!.inSeconds
                    .toDouble(), //without ternary it was causing error
                max: context
                        .read<AudioPlayerBloc>()
                        .totalTime
                        .inSeconds
                        .toDouble() +
                    2, //adding 2 will stop the slider error
                onChangeStart: (value) {
                  context.read<AudioPlayerBloc>().add(OnPressedPause());
                },
                onChanged: (double value) {
                  context
                      .read<AudioPlayerBloc>()
                      .audioPlayer
                      .seek(Duration(seconds: value.toInt()));
                },
                onChangeEnd: (double value) {
                  context.read<AudioPlayerBloc>().add(OnPressedPlay());
                },
              ),
            );
          } 
          return SliderTheme(
            data: SliderThemeData(
                overlayShape: SliderComponentShape.noThumb,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                trackHeight: 1),
            child: Slider.adaptive(
                activeColor: Colors.red,
                inactiveColor: Colors.white,
                value: 0,
                onChanged: (_) {}),
          );
        },
      ),
    );
  }
}
