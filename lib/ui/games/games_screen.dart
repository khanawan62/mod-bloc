import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mod_bloc/ui/shared/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Games"),
      body: Center(
        child: TextButton(
            onPressed: () async {
              await LaunchApp.openApp(
                  androidPackageName: 'com.dotgears.flappybird',
                  iosUrlScheme: 'flappy://');
            },
            child: const Text("launch", style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
