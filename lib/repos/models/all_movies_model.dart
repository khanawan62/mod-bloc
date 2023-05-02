class AllMoviesModel {
  String genreTitle;
  List<String> thumbnails= [];

  AllMoviesModel(this.genreTitle, this.thumbnails);

  AllMoviesModel.fromMap(Map<String, dynamic> json)
      : genreTitle = json["genreTitle"],
        thumbnails = json["thumbnails"];
}