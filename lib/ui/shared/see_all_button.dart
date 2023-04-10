import 'package:flutter/material.dart';
class SeeAllButton extends StatelessWidget {
  const SeeAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        children: const [
          Text(
          "See All",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
         SizedBox(width: 10),
        Icon(Icons.arrow_forward_ios, size: 20, color: Colors.white)
        ],
      ),
    );
  }
}