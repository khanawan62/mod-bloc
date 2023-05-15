import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/repos/services/thumbnail_service.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_state.dart';

class ThumbnailsCubit extends Cubit<ThumbnailsState> {
  ThumbnailsCubit(super.initialState);
  final ThumbnailService _thumbnailService = ThumbnailService();
  String _genreName = "";
  String get genreName => _genreName;
  bool _isScreenAudio = false;
  bool get isScreenAudio => _isScreenAudio;

  ///above bool variable is used at
  ///thumbnails screen to correcnly dispaly the thumbnails
  ///as audio thumbnails are shown in landscape fashion
  ///and all other are shown in vertical manner
  onPressedGenre(
      {required String endPoint,
      required String category,
      required String industry,
      required String genre,
      required String screen}) async {
    _genreName = genre;
    if (screen == "audioScreen") {
      _isScreenAudio = true;
    } else {
      _isScreenAudio = false;
    }
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
}
