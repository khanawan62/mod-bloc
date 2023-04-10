class Genre {
  String title = "";
  String imgURL = "";

  Genre(this.title, this.imgURL);

  Map<String, dynamic> toJson() => {'title': title, 'imgURL': imgURL};

  Genre.fromMap(Map<String, dynamic> json)
      : title = json["title"],
        imgURL = json["imgURL"];
}
