import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/new%20audio%20player/widgets/audio_thumbnail.dart';
import 'package:mod_bloc/ui/new%20audio%20player/widgets/left_side_controls.dart';
import '../audio player/audio_player_bloc.dart';
import '../audio player/audio_player_event.dart';
import '../shared/custom_app_bar.dart';
import '../thumbnails/thumbnails_cubit.dart';

class NewAudioPlayerScreen extends StatefulWidget {
  const NewAudioPlayerScreen({super.key});

  @override
  State<NewAudioPlayerScreen> createState() => _NewAudioPlayerScreenState();
}

class _NewAudioPlayerScreenState extends State<NewAudioPlayerScreen> {
  late final String genreName;
  @override
  void initState() {
    context.read<AudioPlayerBloc>().add(OnPressedPlay());
    genreName = context.read<ThumbnailsCubit>().genreName;
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
          appBar:  CustomAppBar(title: genreName[0].toUpperCase() + genreName.substring(1)),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    const Color.fromARGB(255, 22, 21, 21),
                    const Color.fromARGB(255, 63, 38, 34),
                    Colors.grey.shade900
                  ]),
            ),
            child: const Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children:  [LeftSideControls(), AudioThumbnail()],
              ),
            ),
          )),
    );
  }
}
