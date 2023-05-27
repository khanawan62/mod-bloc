import 'package:flutter/material.dart';

import '../../utils/config/routes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // int appBarTapped = 0;
    return GestureDetector(
      onTap: () {
        Routes.pushNamed(Routes.settingsScreen, context);
      //   if (title == "Home" || title == "Movies") {
      //     appBarTapped ++;
      //     if (appBarTapped == 10) {
      //       showDialog(context: context, builder: ((context) =>  PasswordDialog()));
      //       appBarTapped = 0;
      //     }
      // }
      },
      child: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
    );
  }
}
