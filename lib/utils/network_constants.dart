class Constants {
  static String ip = "192.168.100.5";
  static String thumbnailPort = "3000";
  static String staticContentPort = "3001";
  static String baseUrl = "http://$ip:$thumbnailPort";
  static String audioBaseUrl = "http://$ip:$staticContentPort/audio";
  static String videoBaseUrl = "http://$ip:$staticContentPort/videos";
}
