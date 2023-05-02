import 'dart:convert';
import 'package:mod_bloc/repos/models/all_movies_model.dart';

import '../../utils/network_constants.dart';
import 'package:http/http.dart' as http;
import '../models/genre.dart';
import '../models/thumbnail.dart';

class ThumbnailService {
  Future<List<String>> getThumbnails(
      {required String endPoint,
      required String category,
      required String industry,
      required String genre}) async {
    String thumbnailsURL = "${Constants.baseUrl}/$endPoint/";
    List<String> thumbnails = [];
    var res = await http
        .get(Uri.parse("${Constants.baseUrl}/$category/$industry/$genre"));
    for (String i in Thumbnail.fromMap(jsonDecode(res.body)).images) {
      thumbnails.add(thumbnailsURL + i);
    }
    return thumbnails;
  }

  Future<List<AllMoviesModel>> getAllThumbnails(
      {required String endPoint,
      required String category,
      required String industry,
      required List<String> genresTitles}) async {
    String thumbnailsURL = "${Constants.baseUrl}/$endPoint/";
    List<AllMoviesModel> allMovies = [];
    List<String> thumbnails = [];
    for (String genre in genresTitles) {
      var res = await http
          .get(Uri.parse("${Constants.baseUrl}/$category/$industry/$genre"));
      for (String i in Thumbnail.fromMap(jsonDecode(res.body)).images) {
        thumbnails.add(thumbnailsURL + i);
        allMovies.add(AllMoviesModel(genre, thumbnails));
      }
    }
    for (AllMoviesModel amm in allMovies) {
      print (amm.thumbnails);
    }
    return allMovies;
  }
}
