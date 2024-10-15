import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jasbe/auth/presentation/screen/introduction_screen.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/common/themes.dart';
import 'package:jasbe/shared/presentation/screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: context.appname,
      debugShowCheckedModeBanner: false,
      theme: JasbeThemes.light,
      home: const SplashScreen(),
    );
  }
}
