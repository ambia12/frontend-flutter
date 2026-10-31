import 'package:go_router/go_router.dart';
import '../data/models/menu_item_model.dart';
import '../data/models/order_model.dart';
import '../presentation/screens/detail_menu_screen.dart';
import '../presentation/screens/home_menu_screen.dart';
import '../presentation/screens/order_form_screen.dart';
import '../presentation/screens/payment_success_screen.dart';
import '../presentation/screens/qr_landing_screen.dart';

/// Konfigurasi router navigasi aplikasi Kantingo menggunakan go_router.
class AppRouter {
  static const String initialRoute = '/landing';

  static final GoRouter router = GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        path: '/landing',
        name: 'landing',
        builder: (context, state) => const QrLandingScreen(),
      ),
      GoRoute(
        path: '/menu',
        name: 'menu',
        builder: (context, state) {
          final session = state.extra as TableSessionModel?;
          return HomeMenuScreen(session: session);
        },
      ),
      GoRoute(
        path: '/detail',
        name: 'detail',
        builder: (context, state) {
          MenuItemModel? item;
          TableSessionModel? session;

          if (state.extra is Map<String, dynamic>) {
            final extraMap = state.extra as Map<String, dynamic>;
            item = extraMap['item'] as MenuItemModel?;
            session = extraMap['session'] as TableSessionModel?;
          } else if (state.extra is MenuItemModel) {
            item = state.extra as MenuItemModel;
          }

          return DetailMenuScreen(
            item: item,
            session: session,
          );
        },
      ),
      GoRoute(
        path: '/order',
        name: 'order',
        builder: (context, state) {
          final session = state.extra as TableSessionModel?;
          return OrderFormScreen(session: session);
        },
      ),
      GoRoute(
        path: '/payment-success',
        name: 'payment-success',
        builder: (context, state) {
          final session = state.extra as TableSessionModel?;
          return PaymentSuccessScreen(session: session);
        },
      ),
    ],
  );
}

