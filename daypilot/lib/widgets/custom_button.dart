import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

enum ButtonType { filled, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final Color? textColor;
  final Color? backgroundColor;
  final double? width;
  final bool isLoading;
  final bool isDisabled;
  final bool darkMode;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.filled,
    this.textColor,
    this.backgroundColor,
    this.width,
    this.isLoading = false,
    this.isDisabled = false,
    this.darkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = backgroundColor ?? 
        (darkMode ? AppColors.primary : AppColors.primary);
    Color textColorFinal = textColor ?? 
        (darkMode ? Colors.white : Colors.white);

    if (type == ButtonType.outline) {
      return SizedBox(
        width: width ?? double.infinity,
        height: 56,
        child: OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: darkMode
                  ? AppColors.onboardingTextSecondary.withValues(alpha: 0.3)
                  : buttonColor,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: darkMode ? Colors.white : buttonColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      );
    }

    if (type == ButtonType.text) {
      return TextButton(
        onPressed: isDisabled ? null : onPressed,
        style: TextButton.styleFrom(
          minimumSize: Size(width ?? double.infinity, 56),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              )
            : Text(
                text,
                style: GoogleFonts.inter(
                  color: textColorFinal,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      );
    }

    // Filled button (default)
    return SizedBox(
      width: width ?? double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled 
              ? buttonColor.withValues(alpha: 0.5)
              : buttonColor,
          foregroundColor: textColorFinal,
          disabledBackgroundColor: buttonColor.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(text),
      ),
    );
  }
}