import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.darkCard,
      elevation: 0,
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_rounded, 'Home', 0),
          _buildNavItem(Icons.calendar_today_rounded, 'Calendar', 1),
          const SizedBox(width: 48),
          _buildNavItem(Icons.bar_chart_rounded, 'Analytics', 2),
          _buildNavItem(Icons.person_outline_rounded, 'Profile', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = selectedIndex == index;
    final color = isSelected ? AppColors.accentOrange : AppColors.onboardingTextSecondary;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
