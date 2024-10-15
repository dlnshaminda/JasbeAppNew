// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:jasbe/auth/controller/auth_controller.dart';
import 'package:jasbe/auth/model/user.dart';
import 'package:jasbe/auth/presentation/screen/introduction_screen.dart';
import 'package:jasbe/auth/presentation/screen/sign_in_tab.dart';
import 'package:jasbe/auth/presentation/screen/signing_screen.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/main.dart';
import 'package:jasbe/shared/presentation/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 2));
      await authorize(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          context.assets.appLogo,
          width: context.screenWidth * 0.5,
        ),
      ),
    );
  }

  Future<void> authorize(BuildContext context) async {
    JasbeUser? savedUserData = AuthController.instance.loadUserData();

    if (savedUserData != null) {
      AuthController.instance.setUserData(savedUserData);
      Get.offAll(() => const MainScreen(loadAppData: true));
    } else {
      Get.offAll(() => const IntroductionScreen());
    }
  }
}
