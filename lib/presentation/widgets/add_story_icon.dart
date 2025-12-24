import 'package:flutter/material.dart';

class AddStoryIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const AddStoryIcon({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final gradient = isDark
        ? LinearGradient(colors: [Colors.white70, Colors.white])
        : LinearGradient(colors: [Color(0xFF01579B), Color(0xFF54C5F8)]);

    return GestureDetector(
      onTap: onPressed,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return gradient.createShader(bounds);
        },
        child: Icon(Icons.add, size: 32, color: Colors.white),
      ),
    );
  }
}
