import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final bool enabled;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        validator: validator,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: readOnly,
        enabled: enabled,
        style: AppFonts.bodyLarge.copyWith(
          color: enabled ? AppColors.textPrimary : AppColors.textDisabled,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          labelStyle: AppFonts.labelText.copyWith(
            color: AppColors.textSecondary,
          ),
          hintStyle: AppFonts.bodyMedium.copyWith(
            color: AppColors.textDisabled,
          ),
          filled: true,
          fillColor: enabled ? AppColors.cardColor : AppColors.surfaceColor,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.borderFocused,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.borderError),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.borderError,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.5),),
          ),
          counterText: '',
        ),
      ),  
    );
  }
}