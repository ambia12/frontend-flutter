import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/app_theme.dart';
import '../../data/models/menu_item_model.dart';
import '../../data/models/order_model.dart';
import '../widgets/category_chip.dart';
import '../widgets/custom_menu_card.dart';

/// Layar beranda daftar menu makanan & minuman kantin.
class HomeMenuScreen extends StatefulWidget {
  final TableSessionModel? session;

  const HomeMenuScreen({super.key, this.session});

  @override
  State<HomeMenuScreen> createState() => _HomeMenuScreenState();
}

class _HomeMenuScreenState extends State<HomeMenuScreen> {
  String _selectedCategory = 'Semua';
  late final TableSessionModel _currentSession;

  final List<String> _categories = const [
    'Semua',
    'Mie & Makanan',
    'Dimsum & Side',
    'Minuman Segar',
  ];

  @override
  void initState() {
    super.initState();
    _currentSession = widget.session ??
        const TableSessionModel(
          tableNumber: '08',
          customerName: 'Ahmad Rizky',
        );
  }

  List<MenuItemModel> get _filteredMenuItems {
    if (_selectedCategory == 'Semua') {
      return sampleMenuItems;
    }
    return sampleMenuItems
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

  void _navigateToDetail(MenuItemModel item) {
    context.push(
      '/detail',
      extra: {
        'item': item,
        'session': _currentSession,
      },
    );
  }

  void _navigateToOrderForm() {
    context.push('/order', extra: _currentSession);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Kantingo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/landing'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long_rounded),
            tooltip: 'Ringkasan Pesanan',
            onPressed: _navigateToOrderForm,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.table_restaurant_rounded,
                      color: colorScheme.primary,
                      size: AppSpacing.iconMd,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Meja #${_currentSession.tableNumber}',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                        Text(
                          'Pemesan: ${_currentSession.customerName}',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: _navigateToOrderForm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                      child: Text(
                        'Lihat Keranjang',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Kategori Menu',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  return CategoryChip(
                    label: category,
                    isSelected: _selectedCategory == category,
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daftar Menu Favorit',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  '${_filteredMenuItems.length} Pilihan',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            ..._filteredMenuItems.map((item) {
              return CustomMenuCard(
                menuItem: item,
                actionLabel: 'Pilih & Detail >',
                onActionPressed: () => _navigateToDetail(item),
                onTap: () => _navigateToDetail(item),
              );
            }),
          ],
        ),
      ),
    );
  }
}

