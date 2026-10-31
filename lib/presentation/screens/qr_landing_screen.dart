import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/app_theme.dart';
import '../../data/models/order_model.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

/// Layar simulasi pemindaian QR Code meja interaktif ala sistem restoran modern.
class QrLandingScreen extends StatefulWidget {
  const QrLandingScreen({super.key});

  @override
  State<QrLandingScreen> createState() => _QrLandingScreenState();
}

class _QrLandingScreenState extends State<QrLandingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scannerAnimationController;
  late final Animation<double> _scannerAnimation;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _scannerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scannerAnimation = Tween<double>(begin: 0.1, end: 0.9).animate(
      CurvedAnimation(
        parent: _scannerAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scannerAnimationController.dispose();
    super.dispose();
  }

  Future<void> _handleScanAction({String tableNumber = '08'}) async {
    if (_isScanning) return;
    setState(() => _isScanning = true);

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    final session = TableSessionModel(
      tableNumber: tableNumber,
      customerName: 'Pelanggan Meja $tableNumber',
    );

    context.go('/menu', extra: session);
  }

  void _showManualTableDialog() {
    final controller = TextEditingController(text: '08');
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      builder: (modalContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.lg,
            bottom: MediaQuery.of(modalContext).viewInsets.bottom + AppSpacing.lg,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Masukkan Nomor Meja Manual',
                  style: Theme.of(modalContext).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppSpacing.md),
                CustomTextField(
                  label: 'Nomor Meja',
                  hint: 'Contoh: 12',
                  controller: controller,
                  prefixIcon: Icons.table_restaurant_rounded,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nomor meja tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  text: 'Konfirmasi Meja & Pesan',
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      Navigator.pop(modalContext);
                      _handleScanAction(tableNumber: controller.text.trim());
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restaurant_rounded,
                    color: colorScheme.primary,
                    size: AppSpacing.iconMd,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Kantingo Self-Order',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Scan QR di meja Anda untuk mulai memesan',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => _handleScanAction(tableNumber: '08'),
                child: Container(
                  width: 260.0,
                  height: 260.0,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withAlpha(90),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    border: Border.all(
                      color: colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_2_rounded,
                        size: 140.0,
                        color: colorScheme.onSurfaceVariant.withAlpha(120),
                      ),
                      AnimatedBuilder(
                        animation: _scannerAnimation,
                        builder: (context, child) {
                          return Positioned(
                            top: 240.0 * _scannerAnimation.value,
                            left: 16.0,
                            right: 16.0,
                            child: Container(
                              height: 3.0,
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius:
                                    BorderRadius.circular(AppSpacing.xs),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorScheme.primary.withAlpha(150),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: AppSpacing.md,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.touch_app_rounded,
                                size: AppSpacing.iconSm,
                                color: colorScheme.onPrimaryContainer,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                'Ketuk untuk Scan QR',
                                style: textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Text(
                  'Simulasi Meja Aktif: Meja #08',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Pindai QR Meja Sekarang',
                icon: Icons.qr_code_scanner_rounded,
                isLoading: _isScanning,
                onPressed: () => _handleScanAction(tableNumber: '08'),
              ),
              const SizedBox(height: AppSpacing.sm),
              PrimaryButton(
                text: 'Input Nomor Meja Manual',
                icon: Icons.keyboard_alt_outlined,
                isOutlined: true,
                onPressed: _showManualTableDialog,
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
