import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mod_bloc/utils/app_size.dart';

class SecondaryButtonsRow extends StatelessWidget {
  const SecondaryButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
          ///leave one side, writing EdgeInsets.zero
            ///will cause the button tapping 
            ///pretty difficult
          constraints: const BoxConstraints(),
          onPressed: () {}, icon: FaIcon(FontAwesomeIcons.repeat,
                size: AppSize.screenWidth / 38, color: Colors.white)),
         IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {}, icon: FaIcon(FontAwesomeIcons.shuffle,
                size: AppSize.screenWidth / 38, color: Colors.white)),  
        IconButton(
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
          ///leave one side, writing EdgeInsets.zero
            ///will cause the button tapping 
            ///pretty difficult
          constraints: const BoxConstraints(),
          onPressed: () {}, icon: FaIcon(FontAwesomeIcons.volumeLow,
                size: AppSize.screenWidth / 38, color: Colors.white))
      ],
    );
  }
}
