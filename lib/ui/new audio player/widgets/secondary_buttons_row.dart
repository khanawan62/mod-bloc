import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_event.dart';
import 'package:mod_bloc/utils/app_size.dart';

import '../../audio player/audio_player_bloc.dart';


class SecondaryButtonsRow extends StatelessWidget {
  const SecondaryButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {}, icon: FaIcon(FontAwesomeIcons.repeat,
                size: AppSize.screenWidth / 38, color: Colors.white)),
         IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {}, icon: FaIcon(FontAwesomeIcons.shuffle,
                size: AppSize.screenWidth / 38, color: Colors.white)),  
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {}, icon: FaIcon(FontAwesomeIcons.volumeLow,
                size: AppSize.screenWidth / 38, color: Colors.white))
      ],
    );
  }
}
