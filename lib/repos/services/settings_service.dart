import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<String> getSettingsPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("settingsPassword") ?? "adminuml0011";
  }

  void setIsMenuMultipPage(bool val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("multiPageMenu", val);
  }

  Future<bool> getIsMenuMultipPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("multiPageMenu") ?? true;
  }
}
