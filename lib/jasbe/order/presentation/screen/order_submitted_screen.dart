import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/order/presentation/screen/order_tracking_screen.dart';
import 'package:jasbe/shared/presentation/screens/main_screen.dart';

class OrderSubmittedScreen extends StatefulWidget {
  const OrderSubmittedScreen({super.key});

  @override
  State<OrderSubmittedScreen> createState() => _OrderSubmittedScreenState();
}

class _OrderSubmittedScreenState extends State<OrderSubmittedScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animationOne;
  late Animation<double> animationTwo;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    animationOne = CurvedAnimation(parent: controller, curve: const Interval(0.0, 0.5, curve: Curves.easeOut));
    animationTwo = CurvedAnimation(parent: controller, curve: const Interval(0.5, 1, curve: Curves.easeOut));

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: context.screenHeight * 0.25),
            child: ScaleTransition(
              scale: animationOne,
              child: Container(
                padding: const EdgeInsets.all(50),
                decoration: ShapeDecoration(
                  shape: CircleBorder(side: BorderSide(color: context.borderColor)),
                ),
                child: ScaleTransition(
                  scale: animationTwo,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: context.primary,
                    child: const Icon(
                      Icons.check_rounded,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),
          placeHold(0, context.screenHeight * 0.1),
          const Text("Congratulations !", style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.3),
          placeHold(0, 10),
          const Text("Your order has been placed", textScaleFactor: 1.0),
          const Text("Your order number is #J122", textScaleFactor: 1.0),
          const Expanded(child: SizedBox()),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    backgroundColor: context.foregroundColor,
                    minimumSize: Size(context.screenWidth * 0.6, 40)),
                onPressed: () {
                  //
                  Get.to(() => const OrderTrackingScreen());
                },
                child: const Text("Track Your Order")),
          ),
          placeHold(0, 10),
          Center(
            child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  minimumSize: Size(context.screenWidth * 0.6, 40),
                ),
                onPressed: () {
                  //
                  Get.to(() => const MainScreen());
                },
                child: const Text("Back To Home")),
          )
        ],
      ),
    ));
  }
}
