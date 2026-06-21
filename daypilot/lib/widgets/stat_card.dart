import 'package:flutter/material.dart';
import '../utils/colors.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color backgroundColor;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.statText, size: 22),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.statText,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.statText.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}
