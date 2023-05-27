import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mod_bloc/utils/constants/app_size.dart';

import '../../audio player/audio_player_bloc.dart';

class SecondaryButtonsRow extends StatelessWidget {
  const SecondaryButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    bool loopBtnClicked = false;
    bool shuffleClicked = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StatefulBuilder(
          builder: (context, setState) {
            return IconButton(
                padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),

                ///leave one side, writing EdgeInsets.zero
                ///will cause the button tapping
                ///pretty difficult
                constraints: const BoxConstraints(),
                onPressed: () {
                  setState(() {
                    loopBtnClicked = !loopBtnClicked;
                    if (loopBtnClicked == true) {
                      context
                          .read<AudioPlayerBloc>()
                          .audioPlayer
                          .setReleaseMode(ReleaseMode.loop);
                    } else {
                      context
                          .read<AudioPlayerBloc>()
                          .audioPlayer
                          .setReleaseMode(ReleaseMode.stop);
                    }
                  });
                },
                icon: FaIcon(FontAwesomeIcons.repeat,
                    size: AppSize.screenWidth / 38, color: loopBtnClicked ? Colors.red : Colors.white));
          },
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return IconButton(
                padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),

                ///leave one side, writing EdgeInsets.zero
                ///will cause the button tapping
                ///pretty difficult
                constraints: const BoxConstraints(),
                onPressed: () {
                  setState(() {
                    shuffleClicked = !shuffleClicked;
                  });
                },
                icon: FaIcon(FontAwesomeIcons.shuffle,
                    size: AppSize.screenWidth / 38, color: shuffleClicked ? Colors.red : Colors.white));
          },
        ),
        IconButton(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),

            ///leave one side, writing EdgeInsets.zero
            ///will cause the button tapping
            ///pretty difficult
            constraints: const BoxConstraints(),
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.volumeLow,
                size: AppSize.screenWidth / 38, color: Colors.white))
      ],
    );
  }
}
