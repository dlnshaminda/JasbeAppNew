import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/food/helper/coffee_sizes.dart';
import 'package:jasbe/jasbe/order/controller/cart_controller.dart';
import 'package:jasbe/jasbe/order/presentation/components/cart_item_widget.dart';
import 'package:jasbe/jasbe/order/presentation/screen/check_out_screen.dart';
import 'package:jasbe/main.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
      body: Container(
        height: context.screenHeight,
        width: context.screenWidth,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart Items
            Container(
              height: context.screenHeight * 0.4,
              child: ListView.builder(
                itemCount: cartController.items.length,
                itemBuilder: (_, index) {
                  final cartItem = cartController.items[index];
                  return CartItemTile(cartItem: cartItem, onUpdated: () => setState(() {}));
                },
              ),
            ),

            Divider(color: context.borderColor),

            // Check Out Detail
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Totals", textScaleFactor: 1.0, style: TextStyle(fontWeight: FontWeight.bold)),
                Obx(
                  () => Text(
                    "\$ ${cartController.getAllTotal(cartController.items)}",
                    textScaleFactor: 1.8,
                  ),
                ),
              ],
            ),

            // Selected Venue Option
            cartController.currentVenue.value.name.isEmpty
                ? const Text("No Venue Selected")
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pick Up Venue',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          placeHold(0, 10),
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: ShapeDecoration(
                              shape: StadiumBorder(side: BorderSide(color: context.foregroundColor)),
                            ),
                            child: Text(cartController.currentVenue.value.name),
                          ),
                          placeHold(0, 10),
                          const Text(
                            'Pick Up Time',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          placeHold(0, 10),
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: ShapeDecoration(
                              shape: StadiumBorder(side: BorderSide(color: context.foregroundColor)),
                            ),
                            child: const Text("2.30 pm"),
                          ),
                          placeHold(0, 10),
                          Row(
                            children: [
                              IconButton(
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.lightBlue,
                                    foregroundColor: Colors.white,
                                  ),
                                  iconSize: 30,
                                  onPressed: () {},
                                  icon: const Icon(Icons.add_rounded)),
                              placeHold(10, 0),
                              Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                                      backgroundColor: context.foregroundColor,
                                    ),
                                    onPressed: () {
                                      //
                                      Get.to(() => const CheckoutScreen());
                                    },
                                    child: const Text("Checkout")),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
