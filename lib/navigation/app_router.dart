import 'package:go_router/go_router.dart';
import 'package:indie_commerce/models/payment_model.dart';
import 'package:indie_commerce/models/status_model.dart';
import 'package:indie_commerce/navigation/app_routes.dart';
import 'package:indie_commerce/screen/detail%20product/detail_product_screen.dart';
import 'package:indie_commerce/screen/globals.dart';
import 'package:indie_commerce/screen/login/login_screen.dart';
import 'package:indie_commerce/screen/navbar/navbar.dart';
import 'package:indie_commerce/screen/payment/bank_transfer_screen.dart';
import 'package:indie_commerce/screen/payment/detail_status.dart';
import 'package:indie_commerce/screen/payment/e_wallet_screen.dart';
import 'package:indie_commerce/screen/payment/qr_screen.dart';
import 'package:indie_commerce/screen/payment/select_payment_screen.dart';
import 'package:indie_commerce/screen/payment/status_payment.dart';
import 'package:indie_commerce/screen/register/register_screen.dart';
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
        path: "/register",
        name: AppRoutes.nrRegister,
        builder: (context, state) => const RegisterScreen(),
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
      GoRoute(
        path: "/payment",
        name: AppRoutes.nrPayment,
        builder: (context, state) {
          PaymentModel cartItems = state.extra as PaymentModel;
          return SelectPaymentScreen(
            cartItems: cartItems,
          );
        },
      ),
      GoRoute(
        path: "/qrPayment",
        name: AppRoutes.nrQrPayment,
        builder: (context, state) {
          PaymentModel cartItems = state.extra as PaymentModel;
          return QrScreen(
            cartItems: cartItems,
          );
        },
      ),
      GoRoute(
        path: "/eWalletPayment",
        name: AppRoutes.nrEwalletPayment,
        builder: (context, state) {
          PaymentModel cartItems = state.extra as PaymentModel;
          return EWalletScreen(
            cartItems: cartItems,
          );
        },
      ),
      GoRoute(
        path: "/bankTransferPayment",
        name: AppRoutes.nrBankTransferPayment,
        builder: (context, state) {
          PaymentModel cartItems = state.extra as PaymentModel;
          return BankTransferScreen(
            cartItems: cartItems,
          );
        },
      ),
      GoRoute(
        path: "/statusPayment",
        name: AppRoutes.nrStatusPayment,
        builder: (context, state) {
          return const StatusPayment();
        },
      ),
      GoRoute(
        path: "/statusDetail",
        name: AppRoutes.nrStatusDetail,
        builder: (context, state) {
          StatusModel data = state.extra as StatusModel;
          return DetailStatusScreen(
            data: data,
          );
        },
      ),
    ]);
