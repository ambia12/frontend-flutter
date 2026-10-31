import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/app_theme.dart';
import '../../data/models/order_model.dart';
import '../widgets/primary_button.dart';

/// Layar konfirmasi pesanan berhasil dikirim dan diproses di dapur kantin.
class PaymentSuccessScreen extends StatelessWidget {
  final TableSessionModel? session;

  const PaymentSuccessScreen({super.key, this.session});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    final String orderCode =
        'KTG-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    final TableSessionModel currentSession = session ??
        const TableSessionModel(
          tableNumber: '08',
          customerName: 'Ahmad Rizky',
        );

    final double grandTotal =
        currentSession.totalAmount > 0 ? currentSession.totalAmount * 1.10 : 26400;

    final String formattedGrandTotal =
        'Rp ${grandTotal.toStringAsFixed(0).replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]}.',
            )}';

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.soup_kitchen_rounded,
                    size: 48.0,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Pesanan Sedang Dimasak!',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Dapur Kantingo sedang menyiapkan hidangan lezat Anda.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    border: Border.all(
                      color: colorScheme.outlineVariant.withAlpha(100),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildReceiptRow(
                        context: context,
                        label: 'Nomor Antrean',
                        value: orderCode,
                        isHighlight: true,
                      ),
                      const Divider(height: AppSpacing.md),
                      _buildReceiptRow(
                        context: context,
                        label: 'Lokasi Meja',
                        value: 'Meja #${currentSession.tableNumber}',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _buildReceiptRow(
                        context: context,
                        label: 'Nama Pemesan',
                        value: currentSession.customerName,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _buildReceiptRow(
                        context: context,
                        label: 'Metode Bayar',
                        value: currentSession.paymentMethod,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _buildReceiptRow(
                        context: context,
                        label: 'Estimasi Masak',
                        value: '10 - 15 Menit',
                      ),
                      const Divider(height: AppSpacing.md),
                      _buildReceiptRow(
                        context: context,
                        label: 'Total Terbayar',
                        value: formattedGrandTotal,
                        isHighlight: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  text: 'Pesan Menu Tambahan',
                  icon: Icons.add_circle_outline_rounded,
                  onPressed: () {
                    context.go('/menu', extra: currentSession);
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                PrimaryButton(
                  text: 'Selesai / Meja Lain',
                  isOutlined: true,
                  icon: Icons.qr_code_rounded,
                  onPressed: () {
                    context.go('/landing');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow({
    required BuildContext context,
    required String label,
    required String value,
    bool isHighlight = false,
  }) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.outline,
          ),
        ),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
            color: isHighlight ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

