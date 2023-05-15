import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_bloc.dart';
import 'package:mod_bloc/ui/audio%20player/audio_player_event.dart';
import 'package:mod_bloc/ui/ebook%20reader/bloc/ebook_bloc.dart';
import 'package:mod_bloc/ui/shared/background_gradient.dart';
import 'package:mod_bloc/ui/shared/custom_app_bar.dart';
import 'package:mod_bloc/ui/shared/custom_error_widget.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_cubit.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_state.dart';
import 'package:mod_bloc/ui/video%20player/bloc/video_bloc.dart';
import 'package:mod_bloc/utils/routes.dart';

class ThumbnailsScreen extends StatelessWidget {
  const ThumbnailsScreen({super.key});

  ///thumbnails screen is nothing more than a GridView.count
  ///with its children being generated by List.generate
  ///and the thumbnails (actually thumbnail urls) are passed
  ///as an argument to List.generate widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: context.read<ThumbnailsCubit>().genreName[0].toUpperCase() +
              context.read<ThumbnailsCubit>().genreName.substring(1)),
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
                                thumbnails: state.thumbnails,
                                passedIndex: index));
                            Routes.pushNamed(Routes.audioPlayerScreen, context);
                          } else if (state.screen == "ebooksScreen") {
                            context.read<EbookBloc>().add(EbookInit(
                                thumbnailUrl: state.thumbnails[index]));
                            Routes.pushNamed(Routes.ebookReaderScreen, context);
                          } else {
                            context.read<VideoBloc>().add(VideoInitPressed(
                                thumbnailUrls: state.thumbnails,
                                passedIndex: index));
                            Routes.pushNamed(Routes.videoPlayerScreen, context);
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
              },
              listener: (context, state) {}),
        ),
      ),
    );
  }
}
