import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/food/helper/coffee_sizes.dart';
import 'package:jasbe/jasbe/food/helper/milk_types.dart';
import 'package:jasbe/jasbe/food/model/food.dart';
import 'package:jasbe/jasbe/food/presentation/screens/landing_screen.dart';
import 'package:jasbe/jasbe/order/model/cart_item.dart';
import 'package:jasbe/jasbe/order/presentation/screen/pick_up_option.dart';
import 'package:jasbe/main.dart';
import 'package:jasbe/shared/presentation/components/back_button.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key, required this.food});

  final Food food;

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  ValueNotifier scaleNotifier = ValueNotifier<double>(1);
  late double screenHeight;

  final dragController = DraggableScrollableController();

  int sugarPoint = 1;
  int quantity = 0;
  CoffeeSizes selectedSize = CoffeeSizes.MED;
  MilkTypes selectedMilk = MilkTypes.almond;

  @override
  void initState() {
    initValues();
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      screenHeight = context.screenHeight;

      listenScroll();
    });
  }

  initValues() {
    final matched = cartController.items.firstWhereOrNull((element) => element.item.id == widget.food.id);

    if (matched != null) {
      quantity = matched.quantity;
    }
  }

  void listenScroll() {
    dragController.addListener(() {
      final percentage = dragController.pixels / (screenHeight / 2);
      scaleNotifier.value = percentage;
    });
  }

  double sizeChanger(CoffeeSizes size) {
    double updateSize = 0.0;
    switch (size) {
      case CoffeeSizes.SHORT:
        updateSize = -0.2;
        break;
      case CoffeeSizes.SMALL:
        updateSize = -0.1;
        break;
      case CoffeeSizes.MED:
        updateSize = 0.0;
        break;
      case CoffeeSizes.LARGE:
        updateSize = 0.1;
        break;
      case CoffeeSizes.TALL:
        updateSize = 0.2;
        break;
    }

    return updateSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.surfaceColor,
        appBar: appBar(),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: foodImage(),
        bottomSheet: detailSheet());
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: const BackButtonArrow(),
      systemOverlayStyle: SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: false,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: context.backgroundColor,
      ),
      surfaceTintColor: context.backgroundColor,
    );
  }

  Widget foodImage() {
    return Column(
      children: [
        placeHold(0, kToolbarHeight),
        if (widget.food.image != null)
          Hero(
            tag: widget.food.id.toString(),
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: scaleNotifier,
                child: Image.asset(
                  widget.food.image!,
                  height: context.screenHeight * 0.4,
                ),
                builder: (_, scale, child) => AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: scale + sizeChanger(selectedSize),
                  child: child,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget detailSheet() {
    const sheetDecoration = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(25)), boxShadow: [
      BoxShadow(
        offset: Offset(0, -1),
        blurRadius: 5,
        color: Colors.black12,
      )
    ]);

    return DraggableScrollableSheet(
      controller: dragController,
      initialChildSize: 0.5,
      expand: false,
      minChildSize: 0.5,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
            width: double.infinity,
            decoration: sheetDecoration,
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: scaleNotifier,
                    builder: (_, scale, __) => SizedBox(
                      height: (20 * scale).toDouble(),
                      width: double.maxFinite,
                    ),
                  ),

                  // Title
                  Text(
                    widget.food.name,
                    textScaleFactor: 1.3,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  placeHold(0, 5),

                  // Description
                  Text(
                    widget.food.description,
                    textScaleFactor: 1.0,
                    style: TextStyle(color: context.secondaryTextColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  placeHold(0, 10),

                  // Size Selector
                  Divider(color: context.borderColor, height: 0.5),
                  DefaultTabController(
                    length: 5,
                    initialIndex: 2,
                    child: TabBar(
                      indicatorWeight: 1,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.only(bottom: 45),
                      indicator: BoxDecoration(
                        color: context.primary,
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(5)),
                      ),
                      labelColor: context.primary,
                      dividerColor: context.borderColor,
                      isScrollable: true,
                      onTap: (index) {
                        final size = CoffeeSizes.values[index];
                        setState(() {
                          selectedSize = size;
                        });
                      },
                      tabs: [
                        ...CoffeeSizes.values.map((e) {
                          return Tab(text: e.name);
                        })
                      ],
                    ),
                  ),

                  placeHold(0, 10),

                  // Price Calculator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price Value
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "\$",
                              style: TextStyle(
                                textBaseline: TextBaseline.ideographic,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(text: " ${widget.food.price * quantity} "),
                            TextSpan(
                                text: "\$ ${(widget.food.price + 2.0) * quantity}",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: context.secondaryTextColor,
                                  fontSize: 12,
                                ))
                          ],
                        ),
                      ),

                      // Price Adapter
                      ValueAdapter(
                        value: quantity,
                        onRemoved: () {
                          setState(() {
                            if (quantity == 0) return;
                            quantity--;
                          });
                        },
                        onAdded: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      )
                    ],
                  ),

                  placeHold(0, 10),

                  // Sugar Point
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Sugar Point
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: "Sugar",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ))
                          ],
                        ),
                      ),

                      // Sugar Point Adapter
                      ValueAdapter(
                        value: sugarPoint,
                        onRemoved: () {
                          setState(() {
                            if (sugarPoint == 0) return;
                            sugarPoint--;
                          });
                        },
                        onAdded: () {
                          setState(() {
                            sugarPoint++;
                          });
                        },
                      )
                    ],
                  ),
                  placeHold(0, 5),

                  // Milk Type Selector
                  const Text("Type of milk", textScaleFactor: 1, style: TextStyle(fontWeight: FontWeight.bold)),
                  placeHold(0, 5),
                  Container(
                    height: 45,
                    decoration: ShapeDecoration(
                      shape: StadiumBorder(side: BorderSide(color: context.highlightColor)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButton(
                      underline: const SizedBox.shrink(),
                      onChanged: (value) {
                        setState(() {
                          selectedMilk = value!;
                        });
                      },
                      items: [
                        ...MilkTypes.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(
                              type.parsed(),
                              textScaleFactor: 1.0,
                              // style: TextStyle(color: context.borderColor),
                            ),
                          );
                        }),
                      ],
                      value: selectedMilk,
                      isExpanded: true,
                      itemHeight: 48,
                      borderRadius: BorderRadius.circular(10),
                      hint: const Text("fffff"),
                    ),
                  ),

                  placeHold(0, 10),

                  // Order Button
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(context.screenWidth * 0.5, 0),
                          textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          final carItem = CartItem(id: Random().nextInt(1000), item: widget.food, quantity: quantity);
                          cartController.addItem(carItem);

                          Get.to(() => const PickUpOption());
                        },
                        child: const Text("Place Order")),
                  ),

                  placeHold(0, 20),

                  // Coffee Underneath
                  Center(
                    child: ValueListenableBuilder(
                      valueListenable: scaleNotifier,
                      child: Image.asset(
                        widget.food.image!,
                        height: context.screenHeight * 0.4,
                      ),
                      builder: (_, scale, child) => AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: (scale - 1) + sizeChanger(selectedSize),
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class ValueAdapter extends StatelessWidget {
  const ValueAdapter({super.key, required this.value, required this.onAdded, required this.onRemoved});

  final int value;
  final VoidCallback onAdded;
  final VoidCallback onRemoved;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: ShapeDecoration(
        shape: StadiumBorder(side: BorderSide(color: context.borderColor)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 10,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onRemoved,
                highlightColor: context.borderColor,
                splashColor: context.borderColor,
                child: Icon(
                  Icons.remove,
                  size: 20,
                  color: context.foregroundColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("$value"),
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 10,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onAdded,
                highlightColor: context.borderColor,
                splashColor: context.borderColor,
                child: Icon(
                  Icons.add,
                  size: 20,
                  color: context.foregroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
