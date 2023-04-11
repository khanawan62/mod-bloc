import 'package:http/http.dart' as http;

import '../../utils/constants.dart';

class ConnectionService {
  Future<bool> hasConnection() async {
    try {
      var res = await http
          .get(Uri.parse("${Constants.baseUrl}/conn"));
      if (res.statusCode == 200) {
        print(res.statusCode);
        return true;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Stream<bool> checkConnectionStream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (_) {
      return hasConnection();
    }).asyncMap((value) async => await value);
  }
}
