import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/test%20video%20player/bloc/newcontrols_bloc.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewcontrolsBloc, NewcontrolsState>(
      builder: (context, state) {
        if (state is NewcontrolsShowState) {
          return AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
            centerTitle: true,
          );
        }
        return const SizedBox();
      },
    );
  }
}
