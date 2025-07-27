import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/services/validation_service.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox.shrink();

    final strength = ValidationService.getPasswordStrength(password);

    String strengthText;
    Color strengthColor;
    double progress;

    switch (strength) {
      case PasswordStrength.weak:
        strengthText = 'Weak';
        strengthColor = AppColors.errorColor;
        progress = 0.33;
        break;
      case PasswordStrength.medium:
        strengthText = 'Medium';
        strengthColor = AppColors.warningColor;
        progress = 0.66;
        break;
      case PasswordStrength.strong:
        strengthText = 'Strong';
        strengthColor = AppColors.successColor;
        progress = 1.0;
        break;
    }

    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
        minHeight: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Password Strength: ',
                style: AppFonts.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                strengthText,
                style: AppFonts.bodySmall.copyWith(
                  color: strengthColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 3,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.borderColor,
              valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
              minHeight: 3,
            ),
          ),
        ],
      ),
    );
  }
}