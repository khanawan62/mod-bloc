import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:mod_bloc/repos/models/movie_ui_model.dart';

@immutable
abstract class MoviesState extends Equatable {
}

class MoviesInitState extends MoviesState {
  @override
  List<Object?> get props => [];
}

class MoviesLoadingState extends MoviesState {
  @override
  List<Object?> get props => [];
}

class MoviesLoadedState extends MoviesState {
  final List<MovieUIModel> moviesUIModelList;

  MoviesLoadedState({required this.moviesUIModelList});
  @override
  List<Object?> get props => [moviesUIModelList];
}

class MoviesErrorState extends MoviesState {
  final String errorMsg;
  MoviesErrorState ({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}
