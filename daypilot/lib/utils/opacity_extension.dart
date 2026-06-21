import 'package:flutter/material.dart';

extension OpacityExtension on Color {
  /// Safely apply opacity using withValues()
  Color withOpacity(double opacity) {
    return withValues(alpha: opacity.clamp(0.0, 1.0));
  }
}