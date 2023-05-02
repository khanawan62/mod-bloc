import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/repos/models/all_movies_model.dart';
import 'package:mod_bloc/repos/services/thumbnail_service.dart';
import 'package:mod_bloc/ui/movies/body_listview.dart';
import 'package:mod_bloc/ui/movies/movies_cubit.dart';
import 'package:mod_bloc/ui/movies/movies_state.dart';
import 'package:mod_bloc/ui/shared/background_gradient.dart';
import 'package:mod_bloc/ui/shared/custom_app_bar.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_cubit.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_state.dart';
import 'package:mod_bloc/utils/app_size.dart';

import '../../../repos/models/genre.dart';

class SeeAllMoviesScreen extends StatelessWidget {
  final List<Genre> genreList;
  int globalIndex = 0;
  SeeAllMoviesScreen({super.key, required this.genreList});
  bool isWaiting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Hollywood"), body: bodyLVB());
  }

  getSpecificList(String passedGenre, List<AllMoviesModel> allMovies) {
    List<AllMoviesModel> genreSpecificList = [];
    for (var i in allMovies) {
      if (i.genreTitle == passedGenre) {
        genreSpecificList.add(i);
      }
    }
    for (AllMoviesModel amm in genreSpecificList) {
      print (amm.thumbnails);
    }
    return genreSpecificList;
  }

  Widget bodyLVB() {
    return BlocBuilder<ThumbnailsCubit, ThumbnailsState>(
      builder: (context, state) {
        if (state is AllThumbnailsLoadedState) {
          return ListView.separated(
              itemBuilder: (context, idx) {
                globalIndex = idx;
                getSpecificList(
                    state.allthumbnails[idx].genreTitle, state.allthumbnails);
                return Container(
                  color: idx % 2 == 0 ? Colors.black45 : Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 20),
                    // child: thumbnailsLV(genreList[idx].title, context),
                    child: testCol(state.allthumbnails[idx].genreTitle,
                        getSpecificList(
                    state.allthumbnails[idx].genreTitle, state.allthumbnails)),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 0),
              itemCount: 5);
        }
        return Container();
      },
    );
  }

  Widget thumbnailsLV(String genre, BuildContext context) {
    return FutureBuilder(
        future: context.read<ThumbnailService>().getThumbnails(
              endPoint: "movieThumbnails",
              category: "movies",
              industry: "hollywood",
              genre: genre,
            ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            isWaiting = true;
            return const CustomSpinner();
          } else {
            isWaiting = false;
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
                        return Stack(
                          alignment: Alignment.bottomCenter,
                          children: [Image.network(snapshot.data![idx])],
                        );
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

  Widget testCol(String genre, List<AllMoviesModel> allMovies) {
    int localIndex = 0;
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
                localIndex = idx;
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [Image.network(allMovies[idx].thumbnails[idx])],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemCount: allMovies[localIndex].thumbnails.length),
        )
      ],
    );
  }
}
