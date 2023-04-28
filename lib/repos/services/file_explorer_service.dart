import 'dart:convert';

import 'package:http/http.dart' as http;

class FileExplorerService {
  Future<List<String>> getFileNames(String url) async {
    List<String> fileNames = [];
    var res = await http.get(Uri.parse(url));
    for (String i in jsonDecode(res.body)) {
      fileNames.add(i);
    }
    return fileNames;
  }
}
