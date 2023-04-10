class Thumbnail {
  String description = "";
  List<String> images = [];

  Thumbnail(this.description, this.images);

  Map<String, dynamic> toJson() => {
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
      };

  Thumbnail.fromMap(Map<String, dynamic> json)
      : description = json["description"],
        images = List<String>.from(json["images"].map((x) => x));
}