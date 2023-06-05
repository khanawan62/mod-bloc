import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/cubit/internet_cubit.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //context.read <InternetCubit> ().emit(InternetInitial());
    return Scaffold(
      body: Center(
        child: BlocBuilder<InternetCubit, InternetState>(
          builder: (context, state) {
            if (state is InternetAvailable) {
              return const Text("internet available",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
            }
            if (state is InternetNotAvailable) {
              return const Text("internet not available",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
            }
            return const CustomSpinner();
          },
        ),
      ),
    );
  }
}
