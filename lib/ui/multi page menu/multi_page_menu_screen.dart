import 'package:flutter/material.dart';
import 'package:mod_bloc/utils/app_size.dart';
import '../shared/custom_app_bar.dart';
import 'menu_item.dart';

class MultiPageMenuScreen extends StatelessWidget {
  List<String> imgPathsForMultiPageMenu = [
    "images/movies.jpg",
    "images/music.jpg",
    "images/kids.jpeg",
    "images/tv.jpg",
    "images/ebooks.jpg"
  ];
  static List<String> titlesForMultiPageMenu = ["Movies", "Music", "Kids", "TV Shows", "Ebooks"];
  MultiPageMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Home"),
        body: Center(
          child: SizedBox(
            width: AppSize.screenWidth * 0.9,
            height: AppSize.screenHeight * 0.8,
            child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: imgPathsForMultiPageMenu.length,
                itemBuilder: ((context, index) {
                  return MutliPageMenuItem(
                      imgPath: imgPathsForMultiPageMenu[index],
                      title: titlesForMultiPageMenu[index],
                      passedIndex: index);
                })),
          ),
        ));
  }
}
