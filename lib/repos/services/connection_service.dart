import 'package:http/http.dart' as http;

import '../../utils/constants/network_constants.dart';

class ConnectionService {
  Future<bool> hasConnection() async {
    try {
      var res = await http
          .get(Uri.parse("${Constants.baseUrl}/conn"));
      if (res.statusCode == 200) {
        return true;
      }
    } catch (e) {
    }
    return false;
  }

  Stream<bool> checkConnectionStream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (_) {
      return hasConnection();
    }).asyncMap((value) async => await value);
  }
}
