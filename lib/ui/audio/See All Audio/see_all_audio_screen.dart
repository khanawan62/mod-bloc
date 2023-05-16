import 'package:flutter/material.dart';
import 'package:mod_bloc/ui/audio/See%20All%20Audio/see_all_audio_body_listview.dart';
import 'package:mod_bloc/ui/shared/background_gradient.dart';
import 'package:mod_bloc/ui/shared/custom_app_bar.dart';
import '../../../repos/models/genre.dart';

class SeeAllAudioScreen extends StatelessWidget {
  final List<Genre> genreList;
  final String industry;
  const SeeAllAudioScreen(
      {super.key, required this.genreList, required this.industry});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: industry[0].toUpperCase() + industry.substring(1)),
        body: BackgroundGradient(
            widgetChild:
                SeeAllAudioBodyListview(genreList: genreList, industry: industry)));
  }
}
