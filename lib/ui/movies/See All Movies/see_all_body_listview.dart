import 'package:flutter/material.dart';
import 'package:mod_bloc/repos/models/genre.dart';
import 'package:mod_bloc/ui/movies/See%20All%20Movies/see_all_thumbnails_listview.dart';

class SeeAllBodyListview extends StatelessWidget {
  final List<Genre> genreList;
  final String industry;
  const SeeAllBodyListview(
      {super.key, required this.genreList, required this.industry});    
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, idx) {
          return Container(
            color: idx % 2 == 0 ? Colors.black45 : Colors.black54,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 20),
                child: SeeAllThumbnailsListview(
                    industry: industry, genre: genreList[idx].title)),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 0),
        itemCount: genreList.length);
  }
}