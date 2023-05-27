import 'package:flutter/material.dart';
import 'package:mod_bloc/repos/models/genre.dart';
import 'package:mod_bloc/ui/audio/See%20All%20Audio/see_all_audio_thumbnails_listview.dart';
import 'package:mod_bloc/utils/constants/app_size.dart';

class SeeAllAudioBodyListview extends StatelessWidget {
  final List<Genre> genreList;
  final String industry;
  const SeeAllAudioBodyListview(
      {super.key, required this.genreList, required this.industry});    
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      cacheExtent: AppSize.screenHeight, 
      ///adding above line will prevent listview
      ///from jumping to top while scrolling up
        itemBuilder: (context, idx) {
          return Container(
            height: AppSize.screenHeight / 2.24,
            color: idx.isEven ? Colors.black45 : Colors.black54,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 20),
                child: SeeAllAudioThumbnailsListview(
                    industry: industry, genre: genreList[idx].title)),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 0),
        itemCount: genreList.length);
  }
}
