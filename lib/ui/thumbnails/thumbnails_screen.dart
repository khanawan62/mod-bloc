import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_event.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_state.dart';
import 'package:mod_bloc/ui/shared/background_gradient.dart';
import 'package:mod_bloc/ui/shared/custom_app_bar.dart';
import 'package:mod_bloc/ui/shared/custom_error_widget.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_cubit.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_state.dart';
import 'package:mod_bloc/ui/video%20player/video_player_bloc.dart';
import 'package:mod_bloc/ui/video%20player/video_player_event.dart';
import 'package:mod_bloc/utils/routes.dart';

import '../test video player/bloc/test_bloc.dart';

class ThumbnailsScreen extends StatelessWidget {
  const ThumbnailsScreen({super.key});

  ///thumbnails screen is nothing more than a GridView.count
  ///with its children being generated by List.generate
  ///and the thumbnails (actually thumbnail urls) are passed
  ///as an argument to List.generate widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Thumbnails"),
      body: BackgroundGradient(
        widgetChild: Padding(
          padding: const EdgeInsets.only(left: 4, top: 15),
          child: BlocConsumer<ThumbnailsCubit, ThumbnailsState>(
              builder: (context, state) {
            if (state is ThumbnailsLoadedState) {
              return GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: MediaQuery.of(context).size.height / 24,
                mainAxisSpacing: MediaQuery.of(context).size.height / 14,
                scrollDirection: Axis.vertical,
                children: List.generate(state.thumbnails.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      if (state.screen == "audioScreen") {
                        context.read<AudioPlayerBloc>().add(OnInitEvent(
                            thumbnails: state.thumbnails, passedIndex: index));
                        Routes.pushNamed(Routes.audioPlayerScreen, context);
                      }
                      if (state.screen == "moviesScreen") {
                        // context.read<VideoPlayerBloc>().add(Init(
                        //     thumbnails: state.thumbnails, passedIndex: index));
                        context.read<TestBloc>().add(TestInitEvent(thumbnailUrls: state.thumbnails, passedIndex: index));
                        Routes.pushNamed(Routes.testVideoPlayerScreen, context);
                      }
                    },
                    child: Image.network(
                      state.thumbnails[index],
                      fit: BoxFit.fitHeight,
                    ),
                  );
                }),
              );
            }
            if (state is ThumbnailsLoadingState) {
              return const CustomSpinner();
            }
            if (state is ThumbnailsErrorState) {
              return const CustomErrorWidget(errorMsg: "Failed connection");
            }
            return Container();
          }, listener: (context, state) {
            //print (state.toString());
          }),
        ),
      ),
    );
  }
}
