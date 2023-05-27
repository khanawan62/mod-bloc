import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/settings/cubit/password_cubit.dart';
import 'package:mod_bloc/utils/constants/app_size.dart';
import 'package:mod_bloc/utils/config/routes.dart';

class PasswordDialog extends StatelessWidget {
  const PasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    return AlertDialog(
      content: SizedBox(
        width: AppSize.screenWidth * 0.5,
        height: AppSize.screenHeight * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocConsumer<PasswordCubit, PasswordState>(
              listener: (context, state) {
                if (state is PasswordValid) {
                  Navigator.of(context, rootNavigator: true).pop();
                  Routes.pushNamed(Routes.settingsScreen, context);
                }
              },
              builder: (context, state) {
                if (state is PasswordInvalid) {
                  return Text(state.errorMsg,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red));
                }
                return const SizedBox();
              },
            ),
            SizedBox(
              height: 50,
              child: CupertinoTextField(
                autofocus: true,
                onChanged: (v) {
                  context.read <PasswordCubit> ().reset();
                },
                obscureText: true,
                controller: passwordController,
                placeholder: "Enter admin password",
              ),
            ),
            CupertinoButton.filled(child: const Text("Submit"), onPressed: () {
              context.read <PasswordCubit> ().onPressedSubmit(passwordController.text);
              FocusManager.instance.primaryFocus?.unfocus();
            })
          ],
        ),
      ),
    );
  }
}
