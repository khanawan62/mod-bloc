import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/repos/models/movie_ui_model.dart';
import 'package:mod_bloc/repos/services/movie_service.dart';
import 'package:mod_bloc/ui/movies/movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MovieService _movieService = MovieService();
  MoviesCubit() : super (MoviesInitState()) {
    getMoviesUI();
  }
  getMoviesUI() async {
    emit(MoviesLoadingState());
    List<MovieUIModel> moviesUIModelList = [];
    try {
      moviesUIModelList = await _movieService.getMoviesUIModel();
      emit(MoviesLoadedState(moviesUIModelList: moviesUIModelList));
    } catch (er) {
      emit(MoviesErrorState(errorMsg: er.toString()));
    }
  }
}
