import 'package:flutter/material.dart';
import 'app/app_router.dart';
import 'app/app_theme.dart';

void main() {
  runApp(const KantingoApp());
}

/// Root widget aplikasi Kantingo dengan konfigurasi GoRouter dan Theme.
class KantingoApp extends StatelessWidget {
  const KantingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kantingo',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
