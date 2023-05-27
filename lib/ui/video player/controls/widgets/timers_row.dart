import 'package:flutter/material.dart';
import 'package:mod_bloc/utils/constants/app_size.dart';
import 'package:mod_bloc/utils/time_formatt.dart';
import 'package:video_player/video_player.dart';

class TimersRow extends StatelessWidget {
  final VideoPlayerController controller;
  const TimersRow({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
          width: AppSize.screenWidth * 0.98,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(TimeFormatt.formatDuration(controller.value.position),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text(
                TimeFormatt.formatDuration(controller.value.duration),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
