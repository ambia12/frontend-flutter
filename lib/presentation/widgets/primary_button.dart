import 'package:flutter/material.dart';
import '../../app/app_theme.dart';

/// Komponen tombol utama reusable yang mengadopsi standar Theme dan styling aplikasi.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isOutlined;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isOutlined = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    final Widget buttonContent = isLoading
        ? SizedBox(
            height: AppSpacing.iconSm,
            width: AppSpacing.iconSm,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                isOutlined ? colorScheme.primary : colorScheme.onPrimary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: AppSpacing.iconSm,
                  color: isOutlined
                      ? colorScheme.primary
                      : colorScheme.onPrimary,
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(
                text,
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isOutlined
                      ? colorScheme.primary
                      : colorScheme.onPrimary,
                ),
              ),
            ],
          );

    if (isOutlined) {
      return SizedBox(
        width: double.infinity,
        height: 48.0,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: colorScheme.primary, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
          ),
          child: buttonContent,
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
        child: buttonContent,
      ),
    );
  }
}

