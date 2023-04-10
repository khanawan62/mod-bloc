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
  ThumbnailsLoadedState({required this.thumbnails});
  @override
  List<Object?> get props => [thumbnails];
}
class ThumbnailsErrorState extends ThumbnailsState {
  @override
  List<Object?> get props => [];
}
