class Constants {
  static String ip = "172.20.10.2";
  static String thumbnailPort = "3000";
  static String staticContentPort = "3001";
  static String baseUrl = "http://$ip:$thumbnailPort";
  static String audioBaseUrl = "http://$ip:$staticContentPort/audio";
  static String videoBaseUrl = "http://$ip:$staticContentPort/videos";
  static int stringCutterNumber = 39;
}
