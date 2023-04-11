import 'package:flutter/cupertino.dart';
import 'package:mod_bloc/ui/splash%20screen.dart/splash_screen.dart';
import 'package:mod_bloc/ui/thumbnails/thumbnails_screen.dart';
import '../ui/audio/audio_screen.dart';
import '../ui/movies/movies_screen.dart';

class Routes {
  static const String home = "/";
  static const String audioScreen = "/audioScreen";
  static const String movieScreen = "/moviesScreen";
  static const String thumbnailsScreen = "/thumbnailsScreen";

  static pushNamed(String routeName, BuildContext context) {
    Navigator.pushNamed(context, routeName);
  }

  static pushNamedAndReplace(String routeName, BuildContext context) {
    ///this function is called in custom nav bar
    Navigator.pushReplacementNamed(context, routeName);
  }

  static Route <dynamic>? generateRoutes(RouteSettings settings) {
    ///this function is used for creating cupertino page route,
    ///however can also be used for creating regular routes,
    ///for the ios like animation while navigating
    ///this will be passed as a refrence (just name and no parenthesis) 
    ///to 'onGenerateRoute'property of MaterialApp
    switch (settings.name) {
      case home:
        return CupertinoPageRoute(
            builder: (_) => const SplashScreen(), settings: settings);
      case movieScreen:
        return CupertinoPageRoute(
            builder: (_) => const MoviesScreen(), settings: settings);
      case audioScreen:
        return CupertinoPageRoute(
            builder: (_) => const AudioScreen(), settings: settings);
      case thumbnailsScreen:
        return CupertinoPageRoute(
            builder: (_) => const ThumbnailsScreen(), settings: settings);
    }
  }
}
