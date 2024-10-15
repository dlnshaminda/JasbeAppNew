import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jasbe/auth/presentation/screen/introduction_screen.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/order/model/order.dart';
import 'package:jasbe/main.dart';

class PreviousOrderScreen extends StatefulWidget {
  const PreviousOrderScreen({super.key});

  @override
  State<PreviousOrderScreen> createState() => _PreviousOrderScreenState();
}

class _PreviousOrderScreenState extends State<PreviousOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous Orders"),
        centerTitle: true,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Orders", textScaleFactor: 1.0),
              const Text(
                "Today",
                textScaleFactor: 1.2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              placeHold(0, 10),
              Obx(() => _HistoryOrderCard(
                    order: orderController.sampleSingletonOrder.value,
                  )),
              placeHold(0, 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryOrderCard extends StatelessWidget {
  const _HistoryOrderCard({super.key, required this.order, this.onTap});

  final Order order;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.screenWidth * 0.9,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.lightBlue.withOpacity(0.2),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            DateFormat("MMMM dd, yyy").format(DateTime.now()),
                            textScaleFactor: 1.0,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: CircleAvatar(
                              radius: 1.5,
                              backgroundColor: Colors.black54,
                            ),
                          ),
                          Text(
                            DateFormat("hh:mm").format(DateTime.now()),
                            textScaleFactor: 1.0,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                  placeHold(0, 5),
                  SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        ...order.orders.map((e) {
                          return Positioned(
                            left: order.orders.indexOf(e) * 20,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(e.item.image!),
                              radius: 20,
                              backgroundColor: Colors.white,
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$ ${order.orders.map((e) => e.quantity * e.item.price).reduce((v1, v2) => v1 + v2)}"),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                              minimumSize: const Size(0, 40),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Reorder",
                              textScaleFactor: 1.0,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
