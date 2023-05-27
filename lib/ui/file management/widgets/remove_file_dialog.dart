import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/file_explorer_cubit.dart';

class RemoveFileDialog extends StatelessWidget {
  final String fileName;
  const RemoveFileDialog({super.key, required this.fileName});

  @override
  Widget build(BuildContext context) {
    final fec = context.read<FileExplorerCubit>();
    return AlertDialog(
      content: const Text("Do you want to remove this file?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      actions: [
        CupertinoButton.filled(child: const Text("Ok"), onPressed: () {
          fec.onPressedRemove(fec.getUploadPath(), fileName);
          Navigator.of(context, rootNavigator: true).pop();
        }),
        CupertinoButton(color: Colors.grey, child: const Text("Cancel"), onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        })
      ],
    );
  }
}
