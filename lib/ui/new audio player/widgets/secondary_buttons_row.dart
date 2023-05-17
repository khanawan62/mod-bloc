import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          onPressed: () {}, icon: Icon(Icons.repeat,
                size: AppSize.screenWidth / 38, color: Colors.white)),
         IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {}, icon: Icon(Icons.shuffle_sharp,
                size: AppSize.screenWidth / 38, color: Colors.white)),  
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {}, icon: Icon(Icons.volume_down,
                size: AppSize.screenWidth / 38, color: Colors.white))
      ],
    );
  }
}
