import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mod_bloc/repos/models/movie_ui_model.dart';
import 'package:mod_bloc/utils/constants.dart';

class MovieService {
  Future<List<MovieUIModel>> getMoviesUIModel() async {
    final res = await http.get(Uri.parse("${Constants.baseUrl}/moviesUI"));
    return List<MovieUIModel>.from(
        jsonDecode(res.body).map((i) => MovieUIModel.fromMap(i)));
  }
}
