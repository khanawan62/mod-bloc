import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/file%20management/cubit/file_pick_cubit.dart';
import 'package:mod_bloc/ui/file%20management/cubit/upload_cubit.dart';
import 'package:mod_bloc/ui/file%20management/widgets/choose_files.dart';
import 'package:mod_bloc/ui/file%20management/widgets/percentage_widget.dart';
import 'package:mod_bloc/ui/file%20management/widgets/send_btn.dart';
import 'package:mod_bloc/utils/app_size.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../cubit/file_explorer_cubit.dart';

class UploadAlertDialog extends StatelessWidget {
  const UploadAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final fec = context.read<FileExplorerCubit>();
    final fpc = context.read<FilePickCubit>();
    final uc = context.read<UploadCubit>();
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
              BlocConsumer<UploadCubit, UploadState>(
                listener: (context, state) {
                  if (state is Uploaded) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context, rootNavigator: true).pop();
                      ///above line will remove upload alert dialog properly
                      fec.onPressedGetFilesAndFolders(
                              fec.concatenatedPathList[
                                  fec.concatenatedPathList.length - 1]);
                      ///above call will open the folder once
                      ///the download is complete            
                      fpc.emit(FilePickInitial());
                      uc.emit(UploadInitial());
                      ///w/o above 2 calls, upload dialog
                      ///will have done icon and previosuly selected files 
                      ///count display on dialog.            
                    });
                  }
                },
                builder: (context, state) {
                  if (state is Uploading) {
                    return CircularPercentIndicator(
                      center: PercentageWidget(
                             percentage: state.percentage,
                        fileNumber: state.fileNumber,
                        fileCount: state.fileCount),
                      radius: 80,
                      progressColor: Colors.teal,
                      percent: double.parse(state.percentage) / 100,
                    );
                  }
                  if (state is Uploaded) {
                    return const Center(child: Icon(Icons.done_rounded, size: 70, color: Colors.green,));
                  }
                  return const SizedBox();
                },
              ),
              const Spacer(),
              const SendBtn()
            ],
          ),
        ),
      ),
    );
  }
}
