import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../data/models/menu_item_model.dart';

/// Card reusable untuk menampilkan item menu kantin dengan gaya visual modern.
class CustomMenuCard extends StatelessWidget {
  final MenuItemModel menuItem;
  final VoidCallback? onTap;
  final VoidCallback? onActionPressed;
  final String? actionLabel;
  final bool showDescription;
  final String? customPriceText;

  const CustomMenuCard({
    super.key,
    required this.menuItem,
    this.onTap,
    this.onActionPressed,
    this.actionLabel,
    this.showDescription = true,
    this.customPriceText,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Icon(
                      menuItem.category.contains('Minuman')
                          ? Icons.local_drink_rounded
                          : Icons.restaurant_rounded,
                      color: colorScheme.onPrimaryContainer,
                      size: AppSpacing.iconMd,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.secondaryContainer,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusSm),
                          ),
                          child: Text(
                            menuItem.category,
                            style: textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          menuItem.name,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    customPriceText ?? menuItem.formattedPrice,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
              if (showDescription) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  menuItem.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: AppSpacing.iconSm,
                        color: colorScheme.tertiary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        menuItem.rating.toString(),
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Icon(
                        Icons.schedule_rounded,
                        size: AppSpacing.iconSm,
                        color: colorScheme.outline,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        menuItem.estimatedTime,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                  if (onActionPressed != null && actionLabel != null)
                    TextButton(
                      onPressed: onActionPressed,
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        foregroundColor: colorScheme.primary,
                      ),
                      child: Text(actionLabel!),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

