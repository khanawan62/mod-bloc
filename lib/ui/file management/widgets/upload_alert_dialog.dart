import 'package:flutter/material.dart';
import 'package:mod_bloc/ui/file%20management/widgets/choose_files.dart';
import 'package:mod_bloc/ui/file%20management/widgets/send_btn.dart';
import 'package:mod_bloc/utils/app_size.dart';

class UploadAlertDialog extends StatelessWidget {
  const UploadAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        color: Colors.white,
        height: AppSize.screenHeight / 1.5,
        width: AppSize.screenWidth / 2.5,
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const ChooseFiles(),
              const Spacer(),
              const Spacer(),
              SendBtn()
            ],
          ),
        ),
      ),
    );
  }
}
