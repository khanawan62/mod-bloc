import 'package:flutter/material.dart';
import 'package:mod_bloc/ui/multi%20page%20menu/multi_page_menu_screen.dart';

class HomeScreen extends StatelessWidget {
  ///this will return multi or single page
  ///menu depending on shared perfernces setting values
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiPageMenuScreen();
  }
}