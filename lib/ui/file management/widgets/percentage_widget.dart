import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PercentageWidget extends StatelessWidget {
  final String percentage;
  final String fileNumber;
  final String fileCount;
  const PercentageWidget(
      {super.key,
      required this.percentage,
      required this.fileNumber,
      required this.fileCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("       ${percentage.split(".").first}%",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text("       $fileNumber of $fileCount items",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
