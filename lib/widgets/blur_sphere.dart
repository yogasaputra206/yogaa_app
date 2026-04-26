import 'package:flutter/material.dart';
import 'dart:ui';

class BlurSphere extends StatelessWidget {
  final Color color;

  const BlurSphere({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 384,
      height: 384,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}
