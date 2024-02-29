import 'dart:async';
import 'package:ali_fouad_test/core/storage_service.dart';
import 'package:ali_fouad_test/core/utility/assets_data.dart';
import 'package:ali_fouad_test/core/utility/colors_data.dart';
import 'package:ali_fouad_test/core/views/routes/routes.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: AssetsData.logo,
      nextScreen: const Auth(),
      duration: 2000,
      splashIconSize: 200,
      splashTransition: SplashTransition.slideTransition,
      backgroundColor: ColorsData.whiteColor,
    );
  }
}

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  void checkAuth() async {
    final storage = StorageService().storage;

    String? token = storage.read("token");
    Timer(const Duration(milliseconds: 10), () {
      if (token != null) {
        Get.offAllNamed(Routes.home);
      } else {
        Get.offAllNamed(Routes.landing);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
