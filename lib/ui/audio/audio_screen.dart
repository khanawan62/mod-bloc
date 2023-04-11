import 'package:flutter/material.dart';
import 'package:mod_bloc/ui/shared/custom_bottom_nav_bar.dart';
import '../shared/background_gradient.dart';
import '../shared/custom_app_bar.dart';
import 'body_listview.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomNavBar(screen: "Audio"),
          appBar: CustomAppBar(title: "Audio"),
          body: BackgroundGradient(widgetChild: BodyListView())),
    );
  }
}
