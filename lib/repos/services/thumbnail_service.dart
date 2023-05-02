import 'dart:convert';
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

}
