import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/repos/services/thumbnail_service.dart';
import 'package:mod_bloc/ui/movies/See%20All%20Movies/see_all_body_listview.dart';
import 'package:mod_bloc/ui/shared/background_gradient.dart';
import 'package:mod_bloc/ui/shared/custom_app_bar.dart';

import 'package:mod_bloc/utils/app_size.dart';

import '../../../repos/models/genre.dart';

class SeeAllMoviesScreen extends StatelessWidget {
  final List<Genre> genreList;
  final String industry;
  const SeeAllMoviesScreen(
      {super.key, required this.genreList, required this.industry});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: industry),
        body: BackgroundGradient(
            widgetChild:
                SeeAllBodyListview(genreList: genreList, industry: industry)));
  }
}
