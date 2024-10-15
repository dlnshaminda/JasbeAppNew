import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jasbe/app.dart';
import 'package:jasbe/auth/controller/auth_controller.dart';
import 'package:jasbe/common/colors.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/order/controller/cart_controller.dart';
import 'package:jasbe/jasbe/order/controller/order_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences pref;
late AuthController authController;
late CartController cartController;
late OrderController orderController;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  pref = await SharedPreferences.getInstance();

  setSystemUIOverlay(navigationBarColor: gitHubLightBackgroundColor);

  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => CartController());
  Get.lazyPut(() => OrderController());

  // warning : Not real instance, GetxController instance.
  authController = AuthController.instance;
  cartController = CartController.instance;
  orderController = OrderController.instance;

  runApp(const App());
}
