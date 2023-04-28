import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/file%20management/cubit/file_pick_cubit.dart';
import 'package:mod_bloc/ui/shared/custom_spinner.dart';
import 'package:mod_bloc/utils/app_size.dart';

class ChooseFiles extends StatelessWidget {
  const ChooseFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read <FilePickCubit> ().onPressedFilePick();
      },
      child: DottedBorder(
          color: Colors.indigo,
          dashPattern: const [8, 4],
          strokeWidth: 2,
          child: Container(
            height: 150,
            width: AppSize.screenWidth / 2.8,
            color: Colors.grey.withAlpha(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.folder_copy, size: 50, color: Colors.teal),
                const SizedBox(height: 30),
                const Text("Choose files here...",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Selected files: ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    BlocBuilder<FilePickCubit, FilePickState>(
                        builder: (context, state) {
                      if (state is FilePickLoaded) {
                        return Text(state.fileCount.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold));
                      }
                      if (state is FilePickLoading) {
                        return const SizedBox(height: 15, width: 15, child: CustomSpinner());
                      }
                      return const SizedBox();
                    })
                  ],
                )
              ],
            ),
          )),
    );
  }
}
