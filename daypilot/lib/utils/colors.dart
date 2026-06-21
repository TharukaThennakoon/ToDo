import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6C63FF); // Purple primary
  static const Color primaryLight = Color(0xFF8B83FF);
  static const Color primaryDark = Color(0xFF5A52E0);

  // Secondary Colors
  static const Color secondary = Color(0xFFFF6B6B); // Red for pending
  static const Color success = Color(0xFF2ECC71); // Green for completed
  static const Color warning = Color(0xFFF39C12); // Yellow for ongoing
  static const Color info = Color(0xFF3498DB); // Blue for info

  // Status Colors
  static const Color taskCompleted = Color(0xFF2ECC71);
  static const Color projectSubmitted = Color(0xFF6C63FF);
  static const Color projectOngoing = Color(0xFFF39C12);
  static const Color taskPending = Color(0xFFFF6B6B);

  // Neutral Colors (light theme - used by rest of app)
  static const Color background = Color(0xFFF5F6FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color cardShadow = Color(0x1A000000);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF5A52E0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient statsGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF8B83FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ---- Dark Onboarding Theme ----
  static const Color darkBackground = Color(0xFF0B0F19);
  static const Color darkCard = Color(0xFF1A1F2E);
  static const Color onboardingTextSecondary = Color(0xFF8B92A8);
  static const Color accentOrange = Color(0xFFFF7A45);

  // Dashboard stat card colors
  static const Color statGreen = Color(0xFFB8F397);
  static const Color statYellow = Color(0xFFFBE078);
  static const Color statBlue = Color(0xFFA8D4FF);
  static const Color statTeal = Color(0xFF7FDBCA);
  static const Color statText = Color(0xFF1A1A2E);
}