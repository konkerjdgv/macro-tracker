import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  final double progress; // 0.0 a 1.0
  const ProgressCircle({super.key, this.progress = 0.5});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 12,
            backgroundColor: Colors.white24,
            color: Colors.white,
          ),
          Text("${(progress * 100).toInt()}%", style: const TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }
}
