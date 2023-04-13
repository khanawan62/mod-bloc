import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mod_bloc/ui/audio%20player/current_time.dart';
import 'package:mod_bloc/ui/audio%20player/total_time.dart';
import 'package:mod_bloc/utils/app_size.dart';

class TimersRow extends StatelessWidget {
  const TimersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
            width: AppSize.screenWidth / 1.25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CurrentTime(),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: TotalTime(),
                )
              ],
            )));
  }
}
