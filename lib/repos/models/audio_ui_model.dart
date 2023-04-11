import 'package:mod_bloc/repos/models/genre.dart';

class AudioUIModel {
  String industry = "";
  List<Genre> genres = [];

  AudioUIModel(this.industry, this.genres);

  Map<String, dynamic> toJson() => {
        "industry": industry,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };

  AudioUIModel.fromMap(Map<String, dynamic> json)
      : industry = json["industry"],
        genres = List<Genre>.from(json["genres"].map((e) => Genre.fromMap(e)));
}
