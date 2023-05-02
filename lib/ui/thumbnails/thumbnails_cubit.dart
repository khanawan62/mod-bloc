import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/repos/models/all_movies_model.dart';
import 'package:mod_bloc/repos/services/thumbnail_service.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_state.dart';

class ThumbnailsCubit extends Cubit<ThumbnailsState> {
  ThumbnailsCubit(super.initialState);
  final ThumbnailService _thumbnailService = ThumbnailService();

  onPressedGenre(
      {required String endPoint,
      required String category,
      required String industry,
      required String genre,
      required String screen}) async {
    try {
      emit(ThumbnailsLoadingState());
      List<String> thumbnails = await _thumbnailService.getThumbnails(
          endPoint: endPoint,
          category: category,
          industry: industry,
          genre: genre);
      emit(ThumbnailsLoadedState(thumbnails: thumbnails, screen: screen));
    } catch (er) {
      emit(ThumbnailsErrorState());
    }
  }
  
  testGetAll(
      {required String endPoint,
      required String category,
      required String industry,
      required List<String> genreTitles}) async {
    try {
      emit(ThumbnailsLoadingState());
      List<AllMoviesModel> allThumbnails = await _thumbnailService.getAllThumbnails(
          endPoint: endPoint,
          category: category,
          industry: industry,
          genresTitles: genreTitles);
      emit(AllThumbnailsLoadedState(allthumbnails: allThumbnails));
    } catch (er) {
      emit(ThumbnailsErrorState());
    }
  }
}
