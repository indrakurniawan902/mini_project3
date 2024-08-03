import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:indie_commerce/navigation/app_routes.dart';
import 'package:indie_commerce/screen/splash/cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<SplashCubit>().checkUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          log(state.toString());
          if (state is SplashSuccess) {
            Future.delayed(
              const Duration(seconds: 1),
              () {
                context.goNamed(AppRoutes.nrNavbar);
              },
            );
          } else {
            Future.delayed(
              const Duration(seconds: 1),
              () {
                context.goNamed(AppRoutes.nrLogin);
              },
            );
          }
        },
        child: Center(
          child: Image.asset(
            "assets/images/splash_logo.png",
            width: 200,
          ),
        ),
      ),
    );
  }
}
