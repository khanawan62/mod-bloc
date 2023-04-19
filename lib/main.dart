import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/repos/services/movie_service.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/play_pause_cubit.dart';
import 'package:mod_bloc/ui/audio/audio_cubit.dart';
import 'package:mod_bloc/ui/movies/movies_cubit.dart';
import 'package:mod_bloc/ui/splash%20screen.dart/connection_cubit.dart';
import 'package:mod_bloc/ui/test%20video%20player/bloc/newcontrols_bloc.dart';
import 'package:mod_bloc/ui/test%20video%20player/bloc/test_bloc.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_cubit.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_state.dart';
import 'package:mod_bloc/ui/video%20player/controls/controls_bloc.dart';
import 'package:mod_bloc/ui/video%20player/video_player_bloc.dart';
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
          BlocProvider<AudioPlayerBloc>(
            create: (BuildContext context) =>
                AudioPlayerBloc(),
          ),
          BlocProvider<VideoPlayerBloc>(
            create: (BuildContext context) =>
                VideoPlayerBloc(),
          ),
          BlocProvider<TestBloc>(
            create: (BuildContext context) =>
                TestBloc(),
          ),
          BlocProvider<NewcontrolsBloc>(
            create: (BuildContext context) =>
                NewcontrolsBloc(),
          ),
          BlocProvider<PlayPauseCubit>( //this is redundant and should be removed
            create: (BuildContext context) =>
                PlayPauseCubit(),
          ),
        ],
        child: const MaterialApp(onGenerateRoute: Routes.generateRoutes),
      )));
}
