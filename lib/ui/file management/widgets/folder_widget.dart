import 'package:flutter/material.dart';
import 'package:mod_bloc/ui/file%20management/widgets/file_widget.dart';

class FolderWidget extends StatelessWidget {
  final String folderName;
  const FolderWidget({super.key, required this.folderName});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FileWidget( fileName: folderName),
        const SizedBox(height: 10),
        Text(
          folderName,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    );
  }
}