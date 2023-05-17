import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mod_bloc/ui/audio%20player/audio_progress_slider.dart';
import 'package:mod_bloc/ui/new%20audio%20player/widgets/new_audio_slider.dart';

import '../../../utils/app_size.dart';
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
