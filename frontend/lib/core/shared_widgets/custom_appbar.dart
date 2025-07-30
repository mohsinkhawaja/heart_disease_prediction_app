// Create this file as: lib/core/widgets/custom_app_bar.dart

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Row(
              children: [
                if (showBackButton) ...[
                  IconButton(
                    onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: titleColor ?? AppColors.whiteColor,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: AppFonts.heading2.copyWith(
                      color: titleColor ?? AppColors.whiteColor,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                    textAlign: showBackButton ? TextAlign.left : TextAlign.center,
                  ),
                ),
                if (actions != null) ...actions!,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}