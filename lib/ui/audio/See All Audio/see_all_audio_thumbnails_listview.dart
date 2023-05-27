import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repos/services/thumbnail_service.dart';
import '../../../utils/constants/app_size.dart';
import '../../../utils/config/routes.dart';
import '../../audio player/audio_player_bloc.dart';
import '../../audio player/audio_player_event.dart';
import '../../shared/see_all_button.dart';
import '../../thumbnails/thumbnails_cubit.dart';
import '../../video player/bloc/video_bloc.dart';

class SeeAllAudioThumbnailsListview extends StatefulWidget {
  final String industry;
  final String genre;
  const SeeAllAudioThumbnailsListview(
      {super.key, required this.industry, required this.genre});

  @override
  State<SeeAllAudioThumbnailsListview> createState() =>
      _SeeAllAudioThumbnailsListviewState();
}

class _SeeAllAudioThumbnailsListviewState extends State<SeeAllAudioThumbnailsListview> {
  late Future<List<String>> loadThumbnails;
  @override
  void initState() {
    loadThumbnails = context.read<ThumbnailService>().getThumbnails(
          endPoint: "audioThumbnails",
          category: "audio",
          industry: widget.industry,
          genre: widget.genre,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadThumbnails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: GestureDetector(
                      onTap: () {
                        context.read<ThumbnailsCubit>().onPressedGenre(
                            endPoint: "audioThumbnails",
                            category: "audio",
                            industry: widget.industry,
                            genre: widget.genre,
                            screen: "audioScreen");
                        Routes.pushNamed(Routes.thumbnailsScreen, context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              widget.genre[0].toUpperCase() +
                                  widget.genre.substring(1).toLowerCase(),
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const SeeAllButton()
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                SizedBox(
                  height: AppSize.screenHeight / 3.1,
                  ///changing this height will have
                  ///also change the image height
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, idx) {
                        return GestureDetector(
                            onTap: () {
                             context.read<AudioPlayerBloc>().add(OnInitEvent(
                                  thumbnails: snapshot.data!,
                                  passedIndex: idx));
                              Routes.pushNamed(Routes.audioPlayerScreen, context);
                            },
                            child: Image.network(
                              snapshot.data![idx],
                              fit: BoxFit.fitHeight,
                            ));
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 20),
                      itemCount: snapshot.data!.length),
                )
              ],
            );
          }
        });
  }
}
