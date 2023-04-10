import 'package:flutter/material.dart';
class CustomSpinner extends StatelessWidget {
  const CustomSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: Colors.red),
    );
  }
}