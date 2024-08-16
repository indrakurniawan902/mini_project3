import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indie_commerce/navigation/app_router.dart';
import 'package:indie_commerce/screen/cart/cubits/cart_cubit/cart_cubit.dart';
import 'package:indie_commerce/screen/cart/cubits/price_total_cubit/price_total_cubit.dart';
import 'package:indie_commerce/screen/favorite/add_item_cubit/add_item_cubit.dart';
import 'package:indie_commerce/screen/favorite/favorite_cubit/favorite_cubit.dart';
import 'package:indie_commerce/screen/home/cubit/product_cubit.dart';
import 'package:indie_commerce/screen/detail%20product/detail_product_cubit/detail_product_cubit.dart';
import 'package:indie_commerce/screen/payment/cubit/payment_cubit.dart';
import 'package:indie_commerce/screen/profile/cubit/profile_cubit.dart';
import 'package:indie_commerce/screen/login/cubit/login_cubit.dart';
import 'package:indie_commerce/screen/register/cubit/register_cubit.dart';
import 'package:indie_commerce/screen/splash/cubit/splash_cubit.dart';
import 'package:indie_commerce/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalNotificationService().initLocalNotifications();
  await FcmService().initFCM();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit(),
        ),
        BlocProvider(
          create: (context) => DetailProductCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => PriceTotalCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => AddItemCubit(),
        ),
        BlocProvider(
          create: (context) => PaymentCubit(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationProvider: appGlobalRouter.routeInformationProvider,
        routeInformationParser: appGlobalRouter.routeInformationParser,
        routerDelegate: appGlobalRouter.routerDelegate,
        title: 'Indie Commerce',
        theme: ThemeData(
          fontFamily: "Poppins",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
