import 'package:flutter/material.dart';

class BlurCard extends StatelessWidget {
  final Widget content;
  final String image;

  const BlurCard({super.key, required this.content, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withOpacity(0.7),
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/$image",
            width: 75,
            height: 75,
          ),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }
}
