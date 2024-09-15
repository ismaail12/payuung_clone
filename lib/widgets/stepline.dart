import 'package:flutter/material.dart';

class StepLine extends StatelessWidget {
  final bool isActive;
  final Color color;

  const StepLine({super.key, required this.isActive, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 2,
      color: isActive ? color : color.withOpacity(0.3),
    );
  }
}
