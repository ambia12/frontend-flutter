import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/app_theme.dart';
import '../../data/models/menu_item_model.dart';
import '../../data/models/order_model.dart';
import '../widgets/category_chip.dart';
import '../widgets/primary_button.dart';

/// Layar rincian menu untuk menentukan porsi, level pedas, dan topping.
class DetailMenuScreen extends StatefulWidget {
  final MenuItemModel? item;
  final TableSessionModel? session;

  const DetailMenuScreen({super.key, this.item, this.session});

  @override
  State<DetailMenuScreen> createState() => _DetailMenuScreenState();
}

class _DetailMenuScreenState extends State<DetailMenuScreen> {
  late final MenuItemModel _item;
  late final TableSessionModel _session;

  int _quantity = 1;
  String _selectedSpiceLevel = '';
  String _selectedTopping = '';

  @override
  void initState() {
    super.initState();
    _item = widget.item ?? sampleMenuItems.first;
    _session = widget.session ??
        const TableSessionModel(
          tableNumber: '08',
          customerName: 'Ahmad Rizky',
        );

    if (_item.spiceLevels.isNotEmpty) {
      _selectedSpiceLevel = _item.spiceLevels.first;
    }
    if (_item.toppings.isNotEmpty) {
      _selectedTopping = _item.toppings.first;
    }
  }

  double get _subtotal => _item.price * _quantity;

  String get _formattedSubtotal {
    return 'Rp ${_subtotal.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }

  void _addToOrder() {
    final orderItem = OrderItemModel(
      item: _item,
      quantity: _quantity,
      selectedSpiceLevel: _selectedSpiceLevel,
      selectedTopping: _selectedTopping,
    );

    final updatedSession = TableSessionModel(
      tableNumber: _session.tableNumber,
      customerName: _session.customerName,
      items: [_session.items, [orderItem]].expand((x) => x).toList(),
    );

    context.push('/order', extra: updatedSession);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Menu'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xl,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusLg),
                      ),
                      child: Center(
                        child: Icon(
                          _item.category.contains('Minuman')
                              ? Icons.local_cafe_rounded
                              : Icons.ramen_dining_rounded,
                          size: 96.0,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _item.name,
                                style: textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                _item.description,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          _item.formattedPrice,
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    if (_item.spiceLevels.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        'Pilihan Level Pedas',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _item.spiceLevels.map((level) {
                            return CategoryChip(
                              label: level,
                              isSelected: _selectedSpiceLevel == level,
                              onTap: () {
                                setState(() {
                                  _selectedSpiceLevel = level;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                    if (_item.toppings.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        'Pilihan Topping / Ekstra',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _item.toppings.map((topping) {
                            return CategoryChip(
                              label: topping,
                              isSelected: _selectedTopping == topping,
                              onTap: () {
                                setState(() {
                                  _selectedTopping = topping;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Jumlah Porsi',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        IconButton.filledTonal(
                          onPressed: _quantity > 1
                              ? () => setState(() => _quantity--)
                              : null,
                          icon: const Icon(Icons.remove),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                          ),
                          child: Text(
                            '$_quantity',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                        IconButton.filledTonal(
                          onPressed: () => setState(() => _quantity++),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withAlpha(20),
                    blurRadius: 8.0,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Subtotal',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.outline,
                          ),
                        ),
                        Text(
                          _formattedSubtotal,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: PrimaryButton(
                      text: 'Tambah Pesanan',
                      icon: Icons.add_shopping_cart_rounded,
                      onPressed: _addToOrder,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

