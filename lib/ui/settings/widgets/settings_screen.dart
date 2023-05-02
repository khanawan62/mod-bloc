import 'package:flutter/material.dart';
import 'package:mod_bloc/ui/settings/widgets/settings_card_button.dart';
import 'package:mod_bloc/ui/settings/widgets/switch_button.dart';
import 'package:mod_bloc/utils/app_size.dart';

import '../../shared/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: const CustomAppBar(title: "Settings"),
        body: Center(
          child: Container(
            height: AppSize.screenHeight * 0.7,
            width: AppSize.screenWidth / 2,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SwitchButton(),
                Divider(),
                SettingsCardButton(
                  icon: Icon(
                    Icons.file_upload,
                    size: 40,
                    color: Colors.green,
                  ),
                  txt: "File Management",
                  button: SizedBox(
                    width: 50,
                  ),
                ),
                Divider(),
                SettingsCardButton(icon: Icon (Icons.settings, size: 40, color: Colors.blueAccent,), txt: "System Settings", button: SizedBox(width: 50)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
