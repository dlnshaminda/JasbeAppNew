import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/shared/presentation/components/back_button.dart';
import 'package:jasbe/shared/presentation/screens/main_screen.dart';

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({super.key});

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),

            // App Logo
            Center(child: Image.asset(context.assets.appLogo)),

            const SizedBox(height: 30),

            // Title
            Text(
              "All Done",
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.bold, color: context.primary),
            ),

            const SizedBox(height: 10),
            const Text("Thank you for registering !"),
            const SizedBox(height: 10),
            const Text("Order your next coffee with ease and enjoy our ongoing promotions."),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),

            Center(child: Image.asset(context.assets.coffeeCup)),

            SizedBox(height: MediaQuery.of(context).size.height * 0.1),

            // Let's Go Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 50)),
                onPressed: () {
                  Get.offAll(() => const MainScreen(loadAppData: true));
                },
                child: const Text("Let's go"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
