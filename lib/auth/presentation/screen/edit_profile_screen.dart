import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:jasbe/auth/presentation/screen/introduction_screen.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/main.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Obx(
            () => Column(
              children: [
                placeHold(0, 10),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage(context.assets.sampleProfile),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          toast("#Pick Image");
                        },
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.lightBlue,
                          child: Icon(Icons.add_rounded),
                        ),
                      ),
                    )
                  ],
                ),
                placeHold(0, 30),

                // Name
                _ProfileTile(
                    name: "Name",
                    value: authController.currentUser.value.name,
                    onTap: () {
                      toast("Coming Soon");
                    }),
                placeHold(0, 20),

                _ProfileTile(
                    name: "Phone",
                    value: authController.currentUser.value.phone,
                    onTap: () {
                      toast("Coming Soon");
                    }),
                placeHold(0, 20),

                _ProfileTile(
                    name: "Email",
                    value: authController.currentUser.value.email,
                    onTap: () {
                      toast("Coming Soon");
                    }),
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
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({super.key, required this.name, required this.value, this.onTap});

  final String name;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.screenWidth * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.borderColor),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            highlightColor: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name, textScaleFactor: 1.0),
                  Text(
                    value,
                    textScaleFactor: 1.3,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
