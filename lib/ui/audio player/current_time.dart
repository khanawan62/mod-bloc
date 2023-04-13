import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/time_formatt.dart';
import 'audio_player_bloc.dart';

class CurrentTime extends StatelessWidget {
  const CurrentTime({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
        stream: context.read<AudioPlayerBloc>().getCurrentTimeStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Text(TimeFormatt.formatDuration(snapshot.data!),
                style: const TextStyle(fontSize: 18, color: Colors.white));
          }
          return Container();
        });
  }
}