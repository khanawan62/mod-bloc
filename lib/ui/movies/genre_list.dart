import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_cubit.dart';
import '../../repos/models/genre.dart';
import '../../utils/routes.dart';
import '../shared/see_all_button.dart';

class GenreList extends StatelessWidget {
  final String industry;
  final List<Genre> genres;
  const GenreList({
    super.key,
    required this.industry,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(industry[0].toUpperCase() + industry.substring(1),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SeeAllButton()
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3.7,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, idx) {
                return GestureDetector(
                  onTap: () {
                    context.read<ThumbnailsCubit>().onPressedGenre(
                        endPoint: "movieThumbnails",
                        category: "movies",
                        industry: industry,
                        genre: genres[idx].title,
                        screen: "moviesScreen"
                        );
                    Routes.pushNamed(Routes.thumbnailsScreen, context);
                  },
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 4.2,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CachedNetworkImage(imageUrl: genres[idx].imgURL),
                          Text(
                              genres[idx].title[0].toUpperCase() +
                                  genres[idx].title.substring(1),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold))
                        ],
                      )),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    width: 18,
                  ),
              itemCount: genres.length),
        )
      ],
    );
  }
}
