import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/order/model/cart_item.dart';
import 'package:jasbe/main.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool orderReady = false;
  bool orderCanceled = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        orderReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        width: context.screenWidth,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              placeHold(0, context.screenHeight * 0.05),

              // App Logo
              Center(child: Image.asset(context.assets.appLogo, width: 100)),

              placeHold(0, 15),

              // Title Bar
              SizedBox(
                width: double.maxFinite,
                child: Stack(
                  children: [
                    Positioned(
                      left: 10,
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.chevron_left)),
                    ),
                    const Center(
                      child: Text("Order Detail", style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.3),
                    ),
                  ],
                ),
              ),

              placeHold(0, 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Order #J1222", textScaleFactor: 1.1, style: TextStyle(fontWeight: FontWeight.bold)),
                  AnimatedCrossFade(
                    sizeCurve: Curves.bounceInOut,
                    duration: const Duration(milliseconds: 400),
                    crossFadeState: orderReady ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    secondChild: const SizedBox.shrink(),
                    firstChild: GestureDetector(
                      onTap: () {
                        setState(() {
                          orderCanceled = !orderCanceled;
                        });
                      },
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: const StadiumBorder(),
                          color: orderCanceled ? Colors.red.withOpacity(0.3) : Colors.green.withOpacity(0.3),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          orderCanceled ? "Cancel" : "Ready",
                          textScaleFactor: 0.8,
                          style: TextStyle(color: orderCanceled ? Colors.red : Colors.green),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  Text(
                    DateFormat("MMMM dd, yyy").format(DateTime.now()),
                    textScaleFactor: 1.0,
                    style: TextStyle(color: context.secondaryTextColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      radius: 1.5,
                      backgroundColor: context.secondaryTextColor,
                    ),
                  ),
                  Text(
                    DateFormat("hh:mm").format(DateTime.now()),
                    textScaleFactor: 1.0,
                    style: TextStyle(color: context.secondaryTextColor),
                  ),
                ],
              ),

              // Cart Items
              Obx(
                () => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orderController.sampleSingletonOrder.value.orders.length,
                  itemBuilder: (_, index) {
                    final cartItem = orderController.sampleSingletonOrder.value.orders[index];
                    return _CartItemTile(cartItem: cartItem);
                  },
                ),
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

              // Selected Venue Option
              Divider(color: context.borderColor),

              // Total
              Obx(() => ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: const Text("Total"),
                    trailing: SizedBox(
                      width: 100,
                      child: Text(
                        "\$ ${(cartController.getAllTotal(cartController.items) + 2.99).toStringAsFixed(2)}",
                        textScaleFactor: 1.8,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              Divider(color: context.borderColor),

              // Payment Method
              ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                title: const Text("Payment Method"),
                trailing: SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        context.assets.masterLogo,
                        width: 35,
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 3, left: 4),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: context.foregroundColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: context.foregroundColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: context.foregroundColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: context.foregroundColor,
                        ),
                      ),
                      const Text(
                        "2048",
                        textAlign: TextAlign.end,
                        textScaleFactor: 1.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CartItemTile extends StatefulWidget {
  const _CartItemTile({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  State<_CartItemTile> createState() => __CartItemTileState();
}

class __CartItemTileState extends State<_CartItemTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: context.screenHeight * 0.08,
            width: context.screenHeight * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: Colors.lightBlueAccent.withOpacity(0.2),
              image: DecorationImage(image: AssetImage(widget.cartItem.item.image!), fit: BoxFit.contain),
            ),
          ),
          placeHold(10, 0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                placeHold(0, 4),
                Text(widget.cartItem.item.name),
                placeHold(0, 4),
                Container(
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: Colors.lightBlue.withOpacity(0.5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  child: const Text("Small", textScaleFactor: 0.8),
                ),
              ],
            ),
          ),
          Text(
            "\$ ${widget.cartItem.item.price * widget.cartItem.quantity}",
            textScaleFactor: 1.2,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
