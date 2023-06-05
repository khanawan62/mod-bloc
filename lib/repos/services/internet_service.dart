import 'dart:io';

class InternetService {
  Future<bool> hasInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

  Stream<bool> checkInternetStream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (_) {
      return hasInternet();
    }).asyncMap((value) async => await value);
  }
}