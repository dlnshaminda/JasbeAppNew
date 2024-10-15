import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/food/helper/data_seeding.dart';
import 'package:jasbe/jasbe/food/model/category.dart';
import 'package:jasbe/jasbe/food/model/coffee.dart';
import 'package:jasbe/jasbe/food/model/food.dart';
import 'package:jasbe/jasbe/food/presentation/components/slider_widget.dart';
import 'package:jasbe/jasbe/food/presentation/screens/food_detail_screen.dart';
import 'package:jasbe/jasbe/order/model/cart_item.dart';
import 'package:jasbe/jasbe/order/presentation/screen/order_tracking_screen.dart';
import 'package:jasbe/main.dart';

class CoffeeLandingScreen extends StatefulWidget {
  const CoffeeLandingScreen({super.key});

  @override
  State<CoffeeLandingScreen> createState() => _CoffeeLandingScreenState();
}

class _CoffeeLandingScreenState extends State<CoffeeLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          placeHold(0, context.screenHeight * 0.06),

          // Header
          const _HeaderBoard(),

          // Carousel Slider [Food]
          FoodSlider(title: "Promotions", foodList: sampleCoffees),

          currentOrder(),

          // Category Bar
          FoodCategoryBar(
            categories: sampleCategories,
            onSelected: (category) {},
          ),

          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
            ),
            itemCount: sampleCoffeesTwo.length,
            itemBuilder: (_, index) => Center(
              child: FoodCard(
                food: sampleCoffeesTwo[index],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget currentOrder() {
    return Obx(
      () => AnimatedCrossFade(
        sizeCurve: Curves.bounceInOut,
        duration: const Duration(milliseconds: 400),
        crossFadeState: orderController.sampleSingletonOrder.value.id != -1 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        secondChild: const SizedBox.shrink(),
        firstChild: Container(
            height: context.screenHeight * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                )
              ],
              color: context.backgroundColor,
            ),
            margin: const EdgeInsets.all(10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.to(() => const OrderTrackingScreen());
                },
                borderRadius: BorderRadius.circular(15),
                highlightColor: context.highlightColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Your most recent order :",
                            maxLines: 2,
                          ),
                          Text(
                            "Ready for pickup",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 35,
                        height: context.screenHeight * 0.05,
                        child: FittedBox(
                          child: Image.asset(
                            context.assets.coffeeCup,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class FoodCard extends StatefulWidget {
  const FoodCard({
    super.key,
    required this.food,
  });

  final Food food;

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  bool isPressing = false;

  pressing() => setState(() => isPressing = true);
  unpressing() => setState(() => isPressing = false);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.27,
      width: context.screenWidth * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.surfaceColor,
        border: Border.all(color: isPressing ? context.highlightColor : Colors.transparent),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            unpressing();
            Get.to(() => FoodDetailScreen(food: widget.food));
          },
          onTapDown: (details) => pressing(),
          onTapCancel: () => unpressing(),
          onTapUp: (details) => unpressing(),
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: LayoutBuilder(
            builder: (_, constraint) => Column(
              children: [
                AnimatedScale(
                  scale: isPressing ? 1.5 : 1,
                  duration: const Duration(milliseconds: 250),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    transform: Matrix4.translationValues(0, isPressing ? -(constraint.maxHeight * 0.1) : 0, 0),
                    child: Hero(
                      tag: widget.food.id.toString(),
                      child: Image.asset(
                        widget.food.image!,
                        height: constraint.maxHeight * 0.5,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "${widget.food.name} \n",
                        style: TextStyle(fontSize: constraint.maxWidth * 0.1),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$ ${widget.food.price}",
                            style: TextStyle(color: context.secondaryTextColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.vibrate();
                              final carItem = CartItem(id: Random().nextInt(1000), item: widget.food, quantity: 1);
                              cartController.addItem(carItem);
                              toast("Added");
                            },
                            child: CircleAvatar(
                              backgroundColor: context.primary,
                              radius: 12,
                              child: const Icon(
                                Icons.add_rounded,
                                size: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).paddingAll(8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderBoard extends StatelessWidget {
  const _HeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Text(
                        "Hello ${authController.currentUser.value.name},",
                        textScaleFactor: 1.1,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text("👋")
                  ],
                ),
                const Text(
                  "Welcome back !",
                  textScaleFactor: 1.3,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Image.asset(context.assets.appLogo, height: 25, fit: BoxFit.fill).onTap(() {
            authController.logOut();
          })
        ],
      ),
    );
  }
}

class FoodCategoryBar extends StatelessWidget {
  const FoodCategoryBar({super.key, required this.categories, this.onSelected});

  final List<FoodCategory> categories;
  final Function(FoodCategory category)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(),
      child: DefaultTabController(
        length: sampleCategories.length,
        child: TabBar(
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: context.primary,
          ),
          labelColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: TextStyle(color: context.textColor),
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          onTap: (index) {
            if (onSelected != null) onSelected!(sampleCategories[index]);
          },
          isScrollable: true,
          tabs: [
            ...categories.map((e) {
              return SizedBox(
                height: 35,
                child: Tab(
                  text: e.name,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
