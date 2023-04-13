import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_cubit.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_event.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_state.dart';
import 'package:mod_bloc/ui/audio%20player/button_row.dart';
import 'package:mod_bloc/ui/audio%20player/song_thumbnail.dart';
import 'package:mod_bloc/ui/audio%20player/timers_row.dart';
import 'package:mod_bloc/ui/shared/background_gradient.dart';
import 'package:mod_bloc/ui/shared/custom_app_bar.dart';
import 'package:mod_bloc/utils/app_size.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  void initState() {
    context.read <AudioPlayerBloc> ().add(OnPressedPlay());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read <AudioPlayerBloc> ().add(OnPressedExit());
        return true;
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: "audio player"),
        body: BackgroundGradient(
          widgetChild: Container(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SongThumbnail(),
                SizedBox(height: AppSize.screenHeight / 74),
                const ButtonRow(),
                SizedBox(height: AppSize.screenHeight / 74),
                const TimersRow()
              ],
            ),
          ),
        )
      ),
    );
  }
}