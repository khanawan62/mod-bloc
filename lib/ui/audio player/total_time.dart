import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/time_formatt.dart';
import 'audio_player_bloc.dart';

class TotalTime extends StatelessWidget {
   ///this widget is just a stream builder
  ///which returns a the text widget 
  ///showing the total time (overall length) of the song being played. 
  ///It is called/used in timers_row widget
  const TotalTime({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
        stream: context.read<AudioPlayerBloc>().getTotatTimeStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            context.read <AudioPlayerBloc> ().totalTime = snapshot.data!;
            return Text(TimeFormatt.formatDuration(snapshot.data!),
                style: const TextStyle(fontSize: 18, color: Colors.white));
          }
          return const SizedBox(height: 20);
          ///above SizedBox is important
          ///w/o it the ui will distort (will do up and down)
          ///when the timers are not shown on screen
        });
  }
}