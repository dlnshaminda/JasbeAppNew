import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/order/presentation/screen/location_selector.dart';
import 'package:jasbe/shared/presentation/screens/main_screen.dart';

class PickUpOption extends StatelessWidget {
  const PickUpOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            placeHold(0, context.screenHeight * 0.1),

            // App Logo
            Center(child: Image.asset(context.assets.appLogo, width: 100)),

            placeHold(0, context.screenHeight * 0.05),

            const Text(
              "Pick Up Options",
              textScaleFactor: 1.8,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),

            const Text('Select your pick up options'),

            placeHold(0, context.screenHeight * 0.1),

            _PickUpCard(
              leading: Icon(IconlyLight.location, color: context.primary, size: 30),
              title: "Use my current location",
              onPressed: () {
                Get.to(() => const LocationSelector(uesCurrentLocation: true));
              },
            ),

            placeHold(0, context.screenHeight * 0.05),

            _PickUpCard(
                leading: SizedBox(
                  width: 35,
                  height: context.screenHeight * 0.05,
                  child: FittedBox(
                    child: Image.asset(
                      context.assets.coffeeCup,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: "Select a location",
                onPressed: () {
                  Get.to(() => const LocationSelector(uesCurrentLocation: false));
                }),

            const Expanded(
              child: SizedBox(),
            ),

            Center(
              child: Text.rich(
                TextSpan(
                  text: "I'll decide later. ",
                  children: [
                    TextSpan(
                      text: "Skip this step",
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () => Get.offAll(() => const MainScreen()),
                    )
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),

            placeHold(0, 100),
          ],
        ),
      ),
    );
  }
}

class _PickUpCard extends StatelessWidget {
  const _PickUpCard({super.key, required this.leading, required this.title, required this.onPressed});

  final Widget leading;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: context.screenHeight * 0.1,
          width: context.screenWidth * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
              )
            ],
            color: context.backgroundColor,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(15),
              highlightColor: context.highlightColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    leading,
                    placeHold(10, 0),
                    Expanded(child: Text(title, maxLines: 2)),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
