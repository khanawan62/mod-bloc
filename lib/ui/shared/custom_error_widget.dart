import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/movies/movies_cubit.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMsg;
 
  const CustomErrorWidget({super.key, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(errorMsg, style:  const TextStyle (color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
          SizedBox(width: MediaQuery.of(context).size.width / 43),
          IconButton(onPressed: () {
          // BlocProvider.of <MoviesBloc>(context).add(MoviErrorEvent());
          //BlocProvider.of <MoviesCubit>(context).getMoviesUI();
          context.read <MoviesCubit> ().getMoviesUI();
          }, icon: Icon(Icons.refresh_outlined, size: MediaQuery.of(context).size.width / 33, color: Colors.red,))
        ],
      ),
    );
  }
}