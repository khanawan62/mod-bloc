import 'package:flutter/material.dart';
import 'package:mod_bloc/ui/new%20audio%20player/widgets/audio_title.dart';
import 'package:mod_bloc/ui/new%20audio%20player/widgets/genre_title.dart';
import '../../../utils/app_size.dart';
import 'new_timers_and_slider_row.dart';
import 'primary_buttons_row.dart';
import 'secondary_buttons_row.dart';

class LeftSideControls extends StatelessWidget {
  const LeftSideControls({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.screenWidth / 3.2,
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(

                ///w/o it, left side controls
                ///will go up and down as the big
                ///multi lined audio title take
                ///a lot of vertical space
                height: AppSize.screenHeight / 11.42,
                child: const AudioTitle()),
            SizedBox(height: AppSize.screenHeight / 40),
            const GenreTitle(),
            SizedBox(height: AppSize.screenHeight / 40),
            const NewTimersRow(),
            SizedBox(height: AppSize.screenHeight / 40),
            const PrimaryButtonsRow(),
            SizedBox(height: AppSize.screenHeight / 40),
            const SecondaryButtonsRow(),
            SizedBox(height: AppSize.screenHeight / 26.66),
            SizedBox(
              width: AppSize.screenWidth / 3.2,
              child: const Divider(
                height: 3,
                color: Colors.white,
              ),
            ),
            // Image.asset(
            //   height: 100,
            //   fit: BoxFit.fitHeight,
            //   "images/giphy 3.gif",
            // ),
          ],
        ),
      ),
    );
  }
}
