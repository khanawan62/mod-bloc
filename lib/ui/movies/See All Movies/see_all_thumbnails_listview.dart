import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repos/services/thumbnail_service.dart';
import '../../../utils/app_size.dart';
import '../../../utils/routes.dart';
import '../../video player/bloc/video_bloc.dart';

class SeeAllThumbnailsListview extends StatelessWidget {
  final String industry;
  final String genre;
  const SeeAllThumbnailsListview(
      {super.key, required this.industry, required this.genre});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<ThumbnailService>().getThumbnails(
              endPoint: "movieThumbnails",
              category: "movies",
              industry: industry,
              genre: genre,
            ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(genre[0].toUpperCase() + genre.substring(1).toLowerCase(),
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 10),
                SizedBox(
                  height: AppSize.screenHeight / 3.7,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, idx) {
                        return GestureDetector(
                            onTap: () {
                              context.read<VideoBloc>().add(VideoInitPressed(
                                  thumbnailUrls: snapshot.data!,
                                  passedIndex: idx));
                              Routes.pushNamed(
                                  Routes.videoPlayerScreen, context);
                            },
                            child: Image.network(snapshot.data![idx]));
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
