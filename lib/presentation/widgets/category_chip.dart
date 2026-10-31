import 'package:flutter/material.dart';
import '../../app/app_theme.dart';

/// Komponen chip reusable untuk pemilihan kategori atau opsi kustomisasi.
class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: Material(
        color: isSelected ? colorScheme.primary : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: AppSpacing.iconSm,
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                ],
                Text(
                  label,
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

