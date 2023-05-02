import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../utils/routes.dart';

class SettingsCardButton extends StatelessWidget {
  final Icon icon;
  final String txt;
  final Widget? button;
  const SettingsCardButton({super.key, required this.icon, required this.txt, this.button});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (txt == "File Management") {
          Routes.pushNamed(Routes.fileExplorerScreen, context);
        }
        if (txt == "System Settings") {
         await openAppSettings();
          ///above method will work after
          ///you stop the app running process with control + c on terminal
          ///and run the app agaian with flutter run
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