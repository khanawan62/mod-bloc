import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/repos/services/thumbnail_service.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_bloc.dart';
import 'package:mod_bloc/ui/audio/audio_cubit.dart';
import 'package:mod_bloc/ui/ebook%20reader/bloc/ebook_bloc.dart';
import 'package:mod_bloc/ui/file%20management/cubit/file_explorer_cubit.dart';
import 'package:mod_bloc/ui/file%20management/cubit/file_pick_cubit.dart';
import 'package:mod_bloc/ui/file%20management/cubit/upload_cubit.dart';
import 'package:mod_bloc/ui/movies/movies_cubit.dart';
import 'package:mod_bloc/ui/settings/cubit/password_cubit.dart';
import 'package:mod_bloc/ui/splash%20screen.dart/connection_cubit.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_cubit.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_state.dart';
import 'package:mod_bloc/ui/video%20player/bloc/video_bloc.dart';
import 'package:mod_bloc/ui/video%20player/controls/bloc/controls_bloc.dart';
import 'package:mod_bloc/utils/config/routes.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  Paint.enableDithering = true;
  ///above line will make color 
  ///gradients look smooth
  runApp(const Mod());
}

class Mod extends StatelessWidget {
  const Mod({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: ((context) => ThumbnailService()),
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
          BlocProvider<EbookBloc>(
            create: (BuildContext context) => EbookBloc(),
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
          BlocProvider<PasswordCubit>(
            create: (BuildContext context) => PasswordCubit(),
          ),
        ],
        child: MaterialApp(
          ///poppins, inter seem good
          ///quickSand is used for testing
          theme: ThemeData(
            textTheme: GoogleFonts.nunitoSansTextTheme(
            )
            // apply(
            //   bodyColor: Colors.amber,
            //   fontFamily: GoogleFonts.spaceGrotesk().fontFamily
            // )
            ///above code is left commented for
            ///reference purposes
          ),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routes.generateRoutes),
      ));
  }
}
