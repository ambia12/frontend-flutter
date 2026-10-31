import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/app_theme.dart';
import '../../data/models/menu_item_model.dart';
import '../../data/models/order_model.dart';
import '../widgets/custom_menu_card.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

/// Layar form checkout pesanan dengan pilihan metode pembayaran QRIS & Tunai.
class OrderFormScreen extends StatefulWidget {
  final TableSessionModel? session;

  const OrderFormScreen({super.key, this.session});

  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  final TextEditingController _notesController = TextEditingController();
  late TableSessionModel _session;
  String _selectedPaymentMethod = 'QRIS';

  @override
  void initState() {
    super.initState();
    final initial = widget.session ??
        const TableSessionModel(tableNumber: '08', customerName: 'Ahmad Rizky');

    _session = initial.items.isEmpty
        ? TableSessionModel(
            tableNumber: initial.tableNumber,
            customerName: initial.customerName,
            items: [
              OrderItemModel(item: sampleMenuItems[0], quantity: 1, selectedSpiceLevel: 'Level 2'),
              OrderItemModel(item: sampleMenuItems[4], quantity: 1, selectedTopping: 'Less Sugar'),
            ],
          )
        : initial;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  double get _subtotal => _session.totalAmount;
  double get _tax => _subtotal * 0.10;
  double get _grandTotal => _subtotal + _tax;

  String _formatCurrency(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }

  void _submitOrder() {
    final confirmed = TableSessionModel(
      tableNumber: _session.tableNumber,
      customerName: _session.customerName,
      items: _session.items,
      paymentMethod: _selectedPaymentMethod == 'QRIS' ? 'QRIS Digital' : 'Tunai / Cash di Kasir',
      notes: _notesController.text.trim(),
    );
    context.go('/payment-success', extra: confirmed);
  }

  Widget _buildPaymentCard(BuildContext context, String title, String subtitle, IconData icon, String value) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isSel = _selectedPaymentMethod == value;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        side: BorderSide(color: isSel ? cs.primary : cs.outlineVariant, width: isSel ? 2.0 : 1.0),
      ),
      child: InkWell(
        onTap: () => setState(() => _selectedPaymentMethod = value),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isSel ? cs.primaryContainer : cs.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: isSel ? cs.primary : cs.outline, size: AppSpacing.iconMd),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                    Text(subtitle, style: tt.bodySmall?.copyWith(color: cs.outline)),
                  ],
                ),
              ),
              Container(
                width: 22.0,
                height: 22.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: isSel ? cs.primary : cs.outline, width: 2.0),
                ),
                child: isSel
                    ? Center(
                        child: Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: cs.primary),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrisPlaceholder(ColorScheme cs, TextTheme tt) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: cs.primary.withAlpha(120)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.qr_code_2_rounded, size: AppSpacing.iconSm, color: cs.primary),
              const SizedBox(width: AppSpacing.xs),
              Text('Simulasi Scan QRIS Kantingo', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: cs.primary)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest.withAlpha(90),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: Center(child: Icon(Icons.qr_code_rounded, size: 85.0, color: cs.onSurface)),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text('Scan untuk bayar: ${_formatCurrency(_grandTotal)}', style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: cs.primary)),
          Text('Mendukung GoPay, OVO, DANA, ShopeePay & M-Banking', textAlign: TextAlign.center, style: tt.bodySmall?.copyWith(color: cs.outline)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Ringkasan Pesanan')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(color: cs.surfaceContainerHighest, borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pesanan Meja #${_session.tableNumber}', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: cs.onSurface)),
                            Text('Pemesan: ${_session.customerName}', style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
                          ],
                        ),
                        Icon(Icons.table_restaurant_rounded, color: cs.primary),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('Item yang Dipesan (${_session.items.length})', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: cs.onSurface)),
                  const SizedBox(height: AppSpacing.xs),
                  ..._session.items.map((orderItem) {
                    final customization = [
                      if (orderItem.selectedSpiceLevel.isNotEmpty) orderItem.selectedSpiceLevel,
                      if (orderItem.selectedTopping.isNotEmpty) orderItem.selectedTopping,
                      '${orderItem.quantity} Porsi',
                    ].join(' • ');

                    return CustomMenuCard(
                      menuItem: orderItem.item,
                      customPriceText: orderItem.formattedSubtotal,
                      showDescription: false,
                      actionLabel: customization,
                    );
                  }),
                  const SizedBox(height: AppSpacing.md),
                  Text('Metode Pembayaran', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: cs.onSurface)),
                  const SizedBox(height: AppSpacing.sm),
                  _buildPaymentCard(context, 'QRIS (E-Wallet / M-Banking)', 'Scan QRIS untuk pembayaran digital instan', Icons.qr_code_scanner_rounded, 'QRIS'),
                  _buildPaymentCard(context, 'Tunai / Cash', 'Bayar langsung di kasir kantin', Icons.payments_outlined, 'Tunai'),
                  if (_selectedPaymentMethod == 'QRIS') _buildQrisPlaceholder(cs, tt),
                  const SizedBox(height: AppSpacing.sm),
                  CustomTextField(
                    label: 'Catatan untuk Dapur (Opsional)',
                    hint: 'Contoh: Jangan terlalu pedas, es dipisah',
                    controller: _notesController,
                    prefixIcon: Icons.notes_rounded,
                    maxLines: 2,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      border: Border.all(color: cs.outlineVariant.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        _buildRow('Subtotal', _formatCurrency(_subtotal)),
                        const SizedBox(height: AppSpacing.xs),
                        _buildRow('PB1 Restoran (10%)', _formatCurrency(_tax)),
                        const Divider(height: AppSpacing.md),
                        _buildRow('Total Pembayaran', _formatCurrency(_grandTotal), isBold: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: cs.surface,
                boxShadow: [BoxShadow(color: cs.shadow.withAlpha(20), blurRadius: 8.0, offset: const Offset(0, -2))],
              ),
              child: PrimaryButton(
                text: 'Konfirmasi Pesanan & Bayar',
                icon: Icons.check_circle_outline_rounded,
                onPressed: _submitOrder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: tt.bodyMedium?.copyWith(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: isBold ? cs.onSurface : cs.outline)),
        Text(value, style: tt.bodyMedium?.copyWith(fontWeight: isBold ? FontWeight.bold : FontWeight.w600, color: isBold ? cs.primary : cs.onSurface)),
      ],
    );
  }
}
