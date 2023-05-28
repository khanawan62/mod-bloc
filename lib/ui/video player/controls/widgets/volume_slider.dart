import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/video%20player/bloc/video_bloc.dart';

import '../../../../utils/constants/app_size.dart';
import '../bloc/controls_bloc.dart';

class VolumeSlider extends StatelessWidget {
  const VolumeSlider({super.key});
  @override
  Widget build(BuildContext context) {
    final ControlsBloc controlsBloc = context.read<ControlsBloc>();
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            width: AppSize.screenWidth / 6.4,
            child: SliderTheme(
              data: SliderThemeData(
                  overlayShape: SliderComponentShape.noThumb,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                  trackHeight: 1),
              child: Slider.adaptive(
                activeColor: Colors.red,
                inactiveColor: Colors.white,
                value: AppSize.sliderValue,
                max: 1,
                onChangeStart: (nv) {
                  setState(() => AppSize.sliderValue = nv);
                  context
                      .read<ControlsBloc>()
                      .add(ControlsHideAfterDelayPressed());      
                },
                onChanged: (double nv) {
                  setState(() => AppSize.sliderValue = nv);
                  controlsBloc.add(ControlsHideAfterDelayPressed());
                  context.read<VideoBloc> ().videoPlayerController.setVolume(AppSize.sliderValue);
                },
                onChangeEnd: (double nv) {
                  setState(() => AppSize.sliderValue = nv);
                  controlsBloc.add(ControlsHideAfterDelayPressed());
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
