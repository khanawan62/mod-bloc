import 'package:flutter/material.dart';
import 'package:mod_bloc/ui/movies/body_listview.dart';

import '../shared/background_gradient.dart';
import '../shared/custom_app_bar.dart';
import '../shared/custom_bottom_nav_bar.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomNavBar(screen: "Movies"),
        appBar: CustomAppBar(title: "Movies"),
          body: BackgroundGradient(widgetChild: BodyListView())),
    );
  }
}
