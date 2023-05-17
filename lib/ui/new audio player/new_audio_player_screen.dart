import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_state.dart';
import 'package:mod_bloc/ui/new%20audio%20player/widgets/audio_thumbnail.dart';
import 'package:mod_bloc/ui/new%20audio%20player/widgets/audio_title.dart';
import 'package:mod_bloc/ui/new%20audio%20player/widgets/left_side_controls.dart';
import 'package:mod_bloc/ui/new%20audio%20player/widgets/primary_buttons_row.dart';
import 'package:mod_bloc/ui/new%20audio%20player/widgets/new_timers_and_slider_row.dart';
import 'package:mod_bloc/ui/new%20audio%20player/widgets/secondary_buttons_row.dart';
import 'package:mod_bloc/ui/shared/background_gradient.dart';

import '../audio player/audio_player_bloc.dart';
import '../audio player/audio_player_event.dart';
import '../shared/custom_app_bar.dart';

class NewAudioPlayerScreen extends StatefulWidget {
  const NewAudioPlayerScreen({super.key});

  @override
  State<NewAudioPlayerScreen> createState() => _NewAudioPlayerScreenState();
}

class _NewAudioPlayerScreenState extends State<NewAudioPlayerScreen> {
  @override
  void initState() {
    context.read<AudioPlayerBloc>().add(OnPressedPlay());
    super.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AudioPlayerBloc>().add(OnPressedExit());
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          appBar: const CustomAppBar(title: "audio player"),
          body: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                LeftSideControls(),
                AudioThumbnail()
              ],
            ),
          )),
    );
  }
}
