import 'package:flutter/material.dart';
import 'package:mod_bloc/ui/movies/See%20All%20Movies/see_all_body_listview.dart';
import 'package:mod_bloc/ui/shared/background_gradient.dart';
import 'package:mod_bloc/ui/shared/custom_app_bar.dart';
import '../../../repos/models/genre.dart';

class SeeAllMoviesScreen extends StatelessWidget {
  final List<Genre> genreList;
  final String industry;
  const SeeAllMoviesScreen(
      {super.key, required this.genreList, required this.industry});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: industry[0].toUpperCase() + industry.substring(1)),
        body: BackgroundGradient(
            widgetChild:
                SeeAllBodyListview(genreList: genreList, industry: industry)));
  }
}
