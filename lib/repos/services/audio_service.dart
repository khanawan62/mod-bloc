import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mod_bloc/utils/Constants.dart';

import '../models/audio_ui_model.dart';

class AudioService {
  Future<List<AudioUIModel>> getAudioUIModel() async {
    final res = await http.get(Uri.parse("${Constants.baseUrl}/audioUI"));
    return List<AudioUIModel>.from(
        jsonDecode(res.body).map((i) => AudioUIModel.fromMap(i)));
  }
}
