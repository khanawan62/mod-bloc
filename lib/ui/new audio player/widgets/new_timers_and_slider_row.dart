import 'package:flutter/material.dart';
import 'package:mod_bloc/ui/new%20audio%20player/widgets/new_audio_slider.dart';
import '../../audio player/current_time.dart';
import '../../audio player/total_time.dart';

class NewTimersRow extends StatelessWidget {
  const NewTimersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        CurrentTime(),
        NewAudioSlider(),
        TotalTime()
      ],
    );
  }
}
