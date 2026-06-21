import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final int? maxLines;
  final bool darkMode;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.darkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = darkMode ? AppColors.darkCard : Colors.white;
    final Color textColor = darkMode ? Colors.white : AppColors.textPrimary;
    final Color hintColor = darkMode 
        ? AppColors.onboardingTextSecondary.withValues(alpha: 0.5)
        : AppColors.textHint;
    final Color borderColor = darkMode 
        ? AppColors.onboardingTextSecondary.withValues(alpha: 0.1)
        : AppColors.divider;
    final Color focusedBorderColor = darkMode ? AppColors.primary : AppColors.primary;
    final Color prefixIconColor = darkMode 
        ? AppColors.onboardingTextSecondary
        : AppColors.textHint;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
      style: GoogleFonts.inter(
        color: textColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: GoogleFonts.inter(
          color: hintColor,
          fontSize: 14,
        ),
        labelStyle: GoogleFonts.inter(
          color: hintColor,
          fontSize: 14,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: prefixIconColor, size: 22)
            : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: focusedBorderColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}