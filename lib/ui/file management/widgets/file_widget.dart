import 'package:flutter/material.dart';

class FileWidget extends StatelessWidget {
  final String fileName;
  const FileWidget({super.key, required this.fileName});

  @override
  Widget build(BuildContext context) {
    if (fileName.contains(".mp3")) {
      return const Icon(Icons.music_note, size: 150, color: Colors.blueAccent);
    } else if (fileName.contains(".mp4")) {
      return const Icon(Icons.ondemand_video,
          size: 150, color: Colors.blueAccent);
    } else if (fileName.contains(".pdf")) {
      return const Icon(Icons.picture_as_pdf,
          size: 150, color: Colors.blueAccent);
    } else if (fileName.contains(".jpg") ||
        fileName.contains(".jpeg") ||
        fileName.contains(".png")) {
      return const Icon(Icons.image, size: 150, color: Colors.blueAccent);
    } else {
      return const Icon(Icons.folder, size: 150, color: Colors.blueAccent);
    }
  }
}