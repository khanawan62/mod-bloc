import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/repos/services/movie_service.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_bloc.dart';
import 'package:mod_bloc/ui/audio/audio_cubit.dart';
import 'package:mod_bloc/ui/file%20management/cubit/file_explorer_cubit.dart';
import 'package:mod_bloc/ui/file%20management/cubit/file_pick_cubit.dart';
import 'package:mod_bloc/ui/file%20management/cubit/upload_cubit.dart';
import 'package:mod_bloc/ui/movies/movies_cubit.dart';
import 'package:mod_bloc/ui/splash%20screen.dart/connection_cubit.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_cubit.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_state.dart';
import 'package:mod_bloc/ui/video%20player/bloc/video_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/bloc/controls_bloc.dart';
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
            create: (BuildContext context) => AudioPlayerBloc(),
          ),
          BlocProvider<VideoBloc>(
            create: (BuildContext context) => VideoBloc(),
          ),
          BlocProvider<ControlsBloc>(
            create: (BuildContext context) => ControlsBloc(),
          ),
          BlocProvider<FileExplorerCubit>(
            create: (BuildContext context) => FileExplorerCubit(),
          ),
          BlocProvider<FilePickCubit>(
            create: (BuildContext context) => FilePickCubit(),
          ),
          BlocProvider<UploadCubit>(
            create: (BuildContext context) => UploadCubit(),
          ),
        ],
        child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routes.generateRoutes),
      )));
}
