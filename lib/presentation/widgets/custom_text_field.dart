import 'package:flutter/material.dart';
import '../../app/app_theme.dart';

/// Komponen input form reusable yang mengadopsi standar InputDecorationTheme aplikasi.
class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    size: AppSpacing.iconSm,
                    color: colorScheme.primary,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

