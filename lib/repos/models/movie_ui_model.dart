import 'package:mod_bloc/repos/models/genre.dart';

class MovieUIModel {
  String industry = "";
  List<Genre> genres = [];

  MovieUIModel(this.industry, this.genres);

  Map<String, dynamic> toJson() => {
        "industry": industry,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };

  MovieUIModel.fromMap(Map<String, dynamic> json)
      : industry = json["industry"],
        genres = List<Genre>.from(json["genres"].map((e) => Genre.fromMap(e)));
}
