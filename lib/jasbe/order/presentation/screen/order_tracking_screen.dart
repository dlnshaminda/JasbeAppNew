import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/order/model/cart_item.dart';
import 'package:jasbe/jasbe/order/model/venue.dart';
import 'package:jasbe/jasbe/order/presentation/screen/order_detail_scren.dart';
import 'package:jasbe/main.dart';
import 'package:jasbe/shared/presentation/components/back_button.dart';
import 'package:jasbe/shared/presentation/screens/main_screen.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Order Tracking"),
        leading: IconButton(
          style: IconButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.all(3)),
          splashRadius: 10,
          iconSize: 30,
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.chevron_left_rounded,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemStatusBarContrastEnforced: false,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarContrastEnforced: false,
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(context.assets.currentLocationBackground))),
        child: Stack(
          fit: StackFit.expand,
          children: [
           
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Container(
                width: context.screenWidth,
                height: context.screenHeight * 0.35,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.backgroundColor,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, -1),
                      blurRadius: 5,
                      color: Colors.black12,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    placeHold(0, 10),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.lightBlue.withOpacity(0.2),
                        child: Icon(
                          IconlyLight.location,
                          color: context.foregroundColor,
                        ),
                      ),
                      title: Text("Pickup Address", style: TextStyle(color: context.secondaryTextColor), textScaleFactor: 1.0),
                      subtitle: Text("648 Bridge Street, Richmond", style: TextStyle(color: context.foregroundColor), textScaleFactor: 1.3),
                    ),
                    placeHold(0, 10),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.lightBlue.withOpacity(0.2),
                        child: Icon(
                          Icons.coffee,
                          color: context.foregroundColor,
                        ),
                      ),
                      title: Text("In Progress", style: TextStyle(color: context.secondaryTextColor), textScaleFactor: 1.0),
                      subtitle: Text("Preparing", style: TextStyle(color: context.foregroundColor), textScaleFactor: 1.3),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: context.primary,
                              minimumSize: const Size(double.minPositive, 30),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Order detail "),
                              placeHold(5, 0),
                              Icon(Icons.chevron_right_rounded, color: context.primary),
                            ],
                          ),
                          onPressed: () {
                            Get.to(() => const OrderDetailScreen());
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
