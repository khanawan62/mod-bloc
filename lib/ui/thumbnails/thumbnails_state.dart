import 'package:equatable/equatable.dart';

abstract class ThumbnailsState extends Equatable {}

class ThumbnailsInitState extends ThumbnailsState {
  @override
  List<Object?> get props => [];
}

class ThumbnailsLoadingState extends ThumbnailsState {
  @override
  List<Object?> get props => [];
}

class ThumbnailsLoadedState extends ThumbnailsState {
  final List<String> thumbnails;
  final String screen;
  ///screen variable is used to distinguish which screen
  ///thumbnails screen was opened from.
  ///Whether from audio screen or movies screen or any other screen
  ///and it is passed by context.read<ThumbnailsCubit>().onPressedGenre
  ///of the genre_list widgets of movies and audio screen
  ThumbnailsLoadedState({required this.thumbnails, required this.screen});
  @override
  List<Object?> get props => [thumbnails];
}
class ThumbnailsErrorState extends ThumbnailsState {
  @override
  List<Object?> get props => [];
}
