import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/routes.dart';

class MutliPageMenuItem extends StatelessWidget {
  final String imgPath;
  final String title;
  final int passedIndex;
  const MutliPageMenuItem(
      {super.key,
      required this.imgPath,
      required this.title,
      required this.passedIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == "Movies") {
          Routes.pushNamed(Routes.movieScreen, context);
        }
        if (title == "Music") {
          Routes.pushNamed(Routes.audioScreen, context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(imgPath))),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: dots(),
            )
          ],
        ),
      ),
    );
  }

  Widget dots() {
    return Column(
      children: List.generate(4, (dotsIndex) {
        return Container(
          margin: const EdgeInsets.only(bottom: 5),
          width: 8,
          height: passedIndex == dotsIndex ? 25 : 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
        );
      }),
    );
  }
}