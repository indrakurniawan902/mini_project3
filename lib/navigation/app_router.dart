import 'package:go_router/go_router.dart';
import 'package:indie_commerce/navigation/app_routes.dart';
import 'package:indie_commerce/screen/detail%20product/detail_product_screen.dart';
import 'package:indie_commerce/screen/globals.dart';
import 'package:indie_commerce/screen/login/login_screen.dart';
import 'package:indie_commerce/screen/navbar/navbar.dart';
import 'package:indie_commerce/screen/splash/splash_screen.dart';

final GoRouter appGlobalRouter = GoRouter(
    navigatorKey: AppGlobals.navigatorKey,
    initialLocation: "/splash",
    routes: [
      GoRoute(
        path: "/splash",
        name: AppRoutes.nrSplash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: "/login",
        name: AppRoutes.nrLogin,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: "/navbar",
        name: AppRoutes.nrNavbar,
        builder: (context, state) => const Navbar(),
      ),
      GoRoute(
        path: "/detail",
        name: AppRoutes.nrDetail,
        builder: (context, state) {
          int params = state.extra as int;
          return DetailProductScreen(productId: params);
        },
      ),
      GoRoute(
        path: "/cart",
        name: AppRoutes.nrCart,
        builder: (context, state) {
          return const DetailProductScreen();
        },
      ),
    ]);
