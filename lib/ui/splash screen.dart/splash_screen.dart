import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/shared/background_gradient.dart';
import 'package:mod_bloc/ui/splash%20screen.dart/connection_cubit.dart';
import 'package:mod_bloc/ui/splash%20screen.dart/connection_state.dart';
import 'package:mod_bloc/utils/constants/app_size.dart';
import 'package:mod_bloc/utils/config/routes.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
        body: BackgroundGradient(
          widgetChild: BlocConsumer<ConnectionCubit, APIConnectionState>(
              builder: (context, state) {
                if (state is ConnectingState) {
                  return Center(
                child: 
                LinearPercentIndicator(
                width: AppSize.screenHeight / 2,
                lineHeight: 14.0,
                percent: state.percentage /100,
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
                trailing: Text("${state.percentage.toString().split(".").first}%",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)
                        ),
                leading: const Text("Connecting to server",
                    style:  TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)
                        ),
              )
                // CircularPercentIndicator(
                //   progressColor: Colors.teal,
                //   percent: state.percentage /100,
                //   center: Text("Connecting to server ${state.percentage.toString().split(".").first}%",
                //     style: const TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white)
                //         ),
                //   radius: 180)
                        );
                } 
            return const Center(
                child: Text("Connecting to server...",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)));
          }, listener: (context, state) {
            if (state is HasConnectionState) {
              context.read<ConnectionCubit>().close();
               Routes.pushNamedAndReplace(Routes.index, context);
             // Routes.pushNamedAndReplace(Routes.fileExplorerScreen, context);
            }
            if (state is ConnectionTimedOutState) {
              context.read<ConnectionCubit>().close();
              Routes.pushNamedAndReplace(Routes.gamesScreen, context);
        
              ///replace above line with games screen
              ///since games screen should open on timed out
            }
          }),
        ));
  }
}