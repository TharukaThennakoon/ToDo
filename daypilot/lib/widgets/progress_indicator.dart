import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double value;
  final double height;
  final Color? color;
  final Color? backgroundColor;

  const CustomProgressIndicator({
    super.key,
    required this.value,
    this.height = 6,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0),
        minHeight: height,
        color: color ?? AppColors.primary,
        backgroundColor: backgroundColor ?? AppColors.divider,
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }
}