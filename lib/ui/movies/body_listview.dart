import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/custom_error_widget.dart';
import 'genre_list.dart';
import 'movies_cubit.dart';
import 'movies_state.dart';

class BodyListView extends StatefulWidget {
  const BodyListView({super.key});

  @override
  State<BodyListView> createState() => _BodyListViewState();
}

class _BodyListViewState extends State<BodyListView> {
  @override
  void initState() {
    // context.read<MoviesBloc> ().add (MovieInitEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
            builder: ((context, state) {
              if (state is MoviesLoadedState) {
                return ListView.separated(
              itemBuilder: (context, idx) {
                return Container(
                  color: idx.isEven ? Colors.black45 : Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 20),
                    child: GenreList(industry: state.moviesUIModelList[idx].industry,
                    genres: state.moviesUIModelList[idx].genres,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 0),
              itemCount: state.moviesUIModelList.length);
              }
              if (state is MoviesErrorState) {
                return CustomErrorWidget(errorMsg: state.errorMsg);
              }
              return Container();
            }),
            );
  }
}