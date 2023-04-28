import 'package:flutter/material.dart';

import '../../../utils/routes.dart';

class SettingsCardButton extends StatelessWidget {
  final Icon icon;
  final String txt;
  final Widget? button;
  const SettingsCardButton({super.key, required this.icon, required this.txt, this.button});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (txt == "File Management") {
          Routes.pushNamed(Routes.fileExplorerScreen, context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Text(txt, style: const TextStyle(fontSize: 28, color: Colors.black)),
            button ?? Container()
          ],
        ),
      ),
    );
  }
}