import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/movies/movies_event.dart';
import 'package:mod_bloc/ui/movies/movies_state.dart';

import '../../repos/models/movie_ui_model.dart';
import '../../repos/services/movie_service.dart';

class MoviesBloc extends Bloc<MovieEvent, MoviesState> {
  ///this class is not used anywhere yet
  ///it is only left for reference
  final MovieService _movieService = MovieService();
  MoviesBloc() : super (MoviesInitState()) {

    on<MovieInitEvent>((event, emit) async {
      emit(MoviesLoadingState());
      List<MovieUIModel> moviesUIModelList = [];
      try {
        moviesUIModelList = await _movieService.getMoviesUIModel();
        emit(MoviesLoadedState(moviesUIModelList: moviesUIModelList));
      } catch (er) {
        emit(MoviesErrorState(errorMsg: er.toString()));
      }
    });

    on<MoviErrorEvent>((event, emit) async {
      emit(MoviesLoadingState());
      List<MovieUIModel> moviesUIModelList = [];
      try {
        moviesUIModelList = await _movieService.getMoviesUIModel();
        emit(MoviesLoadedState(moviesUIModelList: moviesUIModelList));
      } catch (er) {
        emit(MoviesErrorState(errorMsg: er.toString()));
      }
    });
    @override
  void onChange(Change <MoviesState> change) {
    super.onChange(change);
    print(change);
  }
  }
}
