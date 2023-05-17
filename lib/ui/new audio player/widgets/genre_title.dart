import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../thumbnails/thumbnails_cubit.dart';

class GenreTitle extends StatelessWidget {
  const GenreTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final String genreName = context.read<ThumbnailsCubit>().genreName;
    return Text(
      genreName[0].toUpperCase() + genreName.substring(1),
      style: const TextStyle(fontSize: 16, color: Colors.white),
    );
  }
}
