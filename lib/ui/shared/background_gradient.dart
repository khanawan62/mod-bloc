import 'package:flutter/material.dart';
import 'package:mod_bloc/utils/config/theme.dart';

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
              colors: AppColors.scaffoldGradient
            )
            ),
            child: widgetChild);
  }
}