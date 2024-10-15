import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jasbe/auth/helper/form_field_utils.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/order/model/order.dart';
import 'package:jasbe/jasbe/order/presentation/screen/card_add_screen.dart';
import 'package:jasbe/jasbe/order/presentation/screen/order_submitted_screen.dart';
import 'package:jasbe/main.dart';
import 'package:jasbe/shared/presentation/components/back_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final promocodeContrller = TextEditingController();

  bool isMasterCard = true;
  int cardType = 0;

  InputDecoration getInputDecoration(String hint, {Widget? suffix}) {
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: context.borderColor));
    final focusBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black38));

    return InputDecoration(
      fillColor: Colors.transparent,
      filled: true,
      isDense: false,
      hintText: hint,
      contentPadding: const EdgeInsetsDirectional.all(10),
      hintStyle: TextStyle(color: context.secondaryTextColor, fontSize: 13),
      enabledBorder: border,
      focusedBorder: focusBorder,
      border: border,
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonArrow(),
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            placeHold(0, 10),
            ListTile(
              dense: true,
              onTap: () {
                setState(() {
                  cardType = 0;
                  isMasterCard = true;
                });
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              title: const Text("Credit Card"),
              leading: Container(
                height: 100,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlue.withOpacity(0.3),
                ),
                child: Center(
                  child: Image.asset(
                    context.assets.masterLogo,
                    height: 30,
                    width: 30,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              trailing: Radio(
                groupValue: cardType,
                value: 0,
                activeColor: context.foregroundColor,
                onChanged: (value) {
                  setState(() {
                    cardType = value!;

                    isMasterCard = value == 0;
                  });
                },
              ),
            ),
            placeHold(0, 10),
            ListTile(
              dense: true,
              onTap: () {
                setState(() {
                  cardType = 1;
                  isMasterCard = false;
                });
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              title: const Text("PayPal"),
              leading: Container(
                height: 100,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlue.withOpacity(0.3),
                ),
                child: Center(
                  child: Image.asset(
                    context.assets.paypalLogo,
                    height: 30,
                    width: 30,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              trailing: Radio(
                groupValue: cardType,
                value: 1,
                activeColor: context.foregroundColor,
                onChanged: (value) {
                  setState(() {
                    cardType = value!;
                    isMasterCard = value == 0;
                  });
                },
              ),
            ),
            placeHold(0, 10),

            // Cards
            SizedBox(
              height: context.screenHeight * 0.2,
              width: double.maxFinite,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          foregroundColor: Colors.white,
                        ),
                        iconSize: 30,
                        onPressed: () {
                          Get.to(() => const CardAddScreen());
                        },
                        icon: const Icon(Icons.add_rounded)),
                    placeHold(20, 0),
                    GestureDetector(
                      child: Image.asset(
                        context.assets.masterCard,
                        height: context.screenHeight * 0.18,
                        width: context.screenWidth * 0.4,
                      ),
                    ),
                    placeHold(20, 0),
                    GestureDetector(
                      child: Image.asset(
                        context.assets.paypalCard,
                        height: context.screenHeight * 0.18,
                        width: context.screenWidth * 0.4,
                      ),
                    )
                  ],
                ),
              ),
            ),

            const Text(
              "Promotion Code",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            placeHold(0, 10),
            TextFormField(
              controller: promocodeContrller,
              cursorColor: context.foregroundColor,
              cursorWidth: 1.2,
              decoration: getInputDecoration("Your code Here",
                  suffix: SizedBox(
                    width: context.screenWidth * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 1,
                          color: context.borderColor,
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: context.primary,
                                minimumSize: const Size(double.minPositive, 30),
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            child: const Text("Add"),
                            onPressed: () {
                              toast(promocodeContrller.text);
                            },
                          ),
                        )
                      ],
                    ),
                  )),
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.visiblePassword,
              autofillHints: const [AutofillHints.newPassword],
            ),

            placeHold(0, 15),

            // Sub total
            Obx(() => ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  title: const Text("Sub total"),
                  trailing: Text("\$ ${cartController.getAllTotal(cartController.items)}"),
                )),

            // Delivery
            const ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              title: Text("Delivery"),
              trailing: Text("\$ 2.99"),
            ),

            Divider(color: context.borderColor),

            Obx(() => ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  title: const Text("Total"),
                  trailing: SizedBox(
                    width: 100,
                    child: Text(
                      "\$ ${(cartController.getAllTotal(cartController.items) + 2.99).toStringAsFixed(2)}",
                      textScaleFactor: 1.8,
                      textAlign: TextAlign.end,
                    ),
                  ),
                )),

            placeHold(0, 15),

            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: context.primary,
                      minimumSize: Size(context.screenWidth * 0.5, 40)),
                  onPressed: () {
                    final order = Order(id: 1, orders: [...cartController.items]);
                    orderController.setOrder(order); // Just Fake for now !
                    Get.to(() => const OrderSubmittedScreen());
                  },
                  child: const Text("Pay")),
            ),
          ],
        ),
      ),
    );
  }
}
