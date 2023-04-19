import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/splash%20screen.dart/connection_cubit.dart';
import 'package:mod_bloc/ui/splash%20screen.dart/connection_state.dart';
import 'package:mod_bloc/utils/app_size.dart';
import 'package:mod_bloc/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    AppSize.screenHeight = MediaQuery.of(context).size.height;
    AppSize.screenWidth = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocConsumer<ConnectionCubit, APIConnectionState>(
            builder: (context, state) {
          return const Center(
              child: Text("Connecting to server...",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)));
        }, listener: (context, state) {
          if (state is HasConnectionState) {
            context.read<ConnectionCubit>().close();
            // Routes.pushNamedAndReplace(Routes.index, context);
            Routes.pushNamedAndReplace(Routes.testVideoPlayerScreen, context);
          }
          if (state is ConnectionTimedOutState) {
            context.read<ConnectionCubit>().close();
            Routes.pushNamedAndReplace(Routes.movieScreen, context);

            ///replace above line with games screen
            ///since games screen should open on timed out
          }
        }));
  }
}