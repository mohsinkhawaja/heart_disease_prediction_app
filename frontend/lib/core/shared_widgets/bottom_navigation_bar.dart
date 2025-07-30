// Create this file as: lib/core/widgets/custom_bottom_nav_bar.dart

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavItem> items;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children:
              items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = index == currentIndex;

                return Expanded(
                  child: InkWell(
                    onTap: () => onTap(index),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isSelected ? item.activeIcon : item.icon,
                            color:
                                isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.textSecondary,
                            size: screenWidth * 0.06,
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            item.label,
                            style: AppFonts.bodySmall.copyWith(
                              color:
                                  isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.textSecondary,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;

  const BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });
}
