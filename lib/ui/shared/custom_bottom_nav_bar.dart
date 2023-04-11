import 'package:flutter/material.dart';
import 'package:mod_bloc/utils/routes.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  const CustomNavBar({super.key, required this.screen});

  Widget button(icon, String txt, Color color, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: MediaQuery.of(context).size.height / 16.44,
          color: color,
        ),
        const SizedBox(height: 10),
        Text(
          txt,
          style: TextStyle(fontFamily: "Lato", fontSize: 20, color: color),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 7.8,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                // Constants.openScreenAndRemovePreviousOnes(
                //     context, const HomeScreen());
              },
              child: button(Icons.home, "Home",
                  screen == "Home" ? Colors.white : Colors.grey, context),
            ),
            GestureDetector(
                onTap: () {
                  if (screen != "Movies") {
                    Routes.pushNamedAndReplace(Routes.movieScreen, context);
                  }
                },
                child: button(Icons.movie_filter_outlined, "Movies",
                    screen == "Movies" ? Colors.white : Colors.grey, context)),
            GestureDetector(
                onTap: () {
                  if (screen != "Audio") {
                    Routes.pushNamedAndReplace(Routes.audioScreen, context);
                  }
                },
                child: button(Icons.music_note, "Audio",
                    screen == "Audio" ? Colors.white : Colors.grey, context)),
            button(Icons.tv, "TV", screen == "TV" ? Colors.white : Colors.grey,
                context),
            button(Icons.videogame_asset, "Games",
                screen == "Games" ? Colors.white : Colors.grey, context),
            button(Icons.menu_book, "Ebooks",
                screen == "Ebooks" ? Colors.white : Colors.grey, context)
          ],
        ));
  }
}
