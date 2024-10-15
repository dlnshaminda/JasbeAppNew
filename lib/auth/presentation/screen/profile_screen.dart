import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:jasbe/auth/presentation/screen/edit_profile_screen.dart';
import 'package:jasbe/auth/presentation/screen/introduction_screen.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/order/presentation/screen/previous_order_screen.dart';
import 'package:jasbe/jasbe/order/presentation/screen/promotion_screen.dart';
import 'package:jasbe/main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        centerTitle: true,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              Obx(
                () => Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(context.assets.sampleProfile),
                    ),
                    placeHold(10, 0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(authController.currentUser.value.name, textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(authController.currentUser.value.phone),
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                        icon: const Icon(IconlyLight.editSquare),
                        onPressed: () => Get.to(() => const EditProfileScreen()),
                      ),
                    )
                  ],
                ),
              ),
              placeHold(0, 30),
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: context.primary,
                  child: const Icon(IconlyLight.location),
                ),
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                title: const Text("Personal Details"),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  toast("#Personal Details");
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: context.primary,
                  child: const Icon(IconlyLight.bag),
                ),
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                title: const Text("Previous Orders"),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  Get.to(() => const PreviousOrderScreen());
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: context.primary,
                  child: const Icon(IconlyLight.wallet),
                ),
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                title: const Text("Promotions"),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  Get.to(() => const PromotionScreen());
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: context.secondaryTextColor,
                  child: const Icon(IconlyLight.chat),
                ),
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                title: const Text("Contact Us"),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  toast("#Contact Us");
                },
              ),
              placeHold(0, 30),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: context.errorColor,
                    ),
                    onPressed: () {
                      authController.logOut();
                      Get.offAll(() => const IntroductionScreen());
                    },
                    child: const Text("Log Out")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
