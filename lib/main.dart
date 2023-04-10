import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/repos/services/movie_service.dart';
import 'package:mod_bloc/ui/movies/movies_bloc.dart';
import 'package:mod_bloc/ui/movies/movies_cubit.dart';
import 'package:mod_bloc/ui/movies/movies_event.dart';
import 'package:mod_bloc/ui/movies/movies_screen.dart';
import 'package:mod_bloc/ui/movies/movies_state.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_cubit.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_state.dart';

void main() {
  runApp(
    RepositoryProvider(create: ((context) => MovieService()),
    child: MultiBlocProvider(
      providers: [
        BlocProvider<MoviesCubit>(
      create: (BuildContext context) => MoviesCubit()),
        BlocProvider<ThumbnailsCubit>(
      create: (BuildContext context) => ThumbnailsCubit(ThumbnailsInitState()),
    ),
      ],
      child: const MaterialApp (
        home: MoviesScreen(),
      ),
    )
  ));
}