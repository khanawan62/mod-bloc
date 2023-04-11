import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/repos/services/movie_service.dart';
import 'package:mod_bloc/ui/audio/audio_cubit.dart';
import 'package:mod_bloc/ui/audio/audio_screen.dart';
import 'package:mod_bloc/ui/movies/movies_bloc.dart';
import 'package:mod_bloc/ui/movies/movies_cubit.dart';
import 'package:mod_bloc/ui/movies/movies_event.dart';
import 'package:mod_bloc/ui/movies/movies_screen.dart';
import 'package:mod_bloc/ui/movies/movies_state.dart';
import 'package:mod_bloc/ui/splash%20screen.dart/connection_cubit.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_cubit.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_state.dart';
import 'package:mod_bloc/utils/routes.dart';

void main() {
  runApp(RepositoryProvider(
      create: ((context) => MovieService()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MoviesCubit>(
              create: (BuildContext context) => MoviesCubit()),
          BlocProvider<AudioCubit>(
              create: (BuildContext context) => AudioCubit()),
          BlocProvider<ConnectionCubit>(
              create: (BuildContext context) => ConnectionCubit()),
          BlocProvider<ThumbnailsCubit>(
            create: (BuildContext context) =>
                ThumbnailsCubit(ThumbnailsInitState()),
          ),
        ],
        child: const MaterialApp(onGenerateRoute: Routes.generateRoutes),
      )));
}
