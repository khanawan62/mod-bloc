import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget widgetChild;
  const BackgroundGradient({super.key, required this.widgetChild});

  @override
  Widget build(BuildContext context) {
    return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              tileMode: TileMode.decal,
              colors: [
                HSLColor.fromColor(Colors.brown).withLightness(0.2).toColor(),
                Colors.brown.shade400,
                Colors.grey,
              ],
            )),
            child: widgetChild);
  }
}