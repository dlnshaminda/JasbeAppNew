
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jasbe/auth/presentation/components/dot_indicator.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/food/model/food.dart';

class FoodSlider extends StatefulWidget {
  const FoodSlider({super.key, required this.foodList, this.title});

  final String? title;

  final List<Food> foodList;

  @override
  State<FoodSlider> createState() => _FoodSliderState();
}

class _FoodSliderState extends State<FoodSlider> {
  ValueNotifier indexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.title != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ).paddingOnly(left: 15, top: 10, bottom: 10),
          ),
        CarouselSlider(
          options: CarouselOptions(
            height: context.screenHeight * 0.2,
            autoPlay: true,
            viewportFraction: 0.6,
            initialPage: 0,
            onPageChanged: (index, reason) {
              indexNotifier.value = index;
            },
          ),
          items: widget.foodList.map((i) {
            return cardDesign(i);
          }).toList(),
        ),
        if (widget.foodList.isNotEmpty) const SizedBox(height: 15),
        if (widget.foodList.isNotEmpty)
          ValueListenableBuilder(
              valueListenable: indexNotifier,
              builder: (_, reactiveValue, __) {
                return DotIndicatorWidget(
                  currentIndex: reactiveValue,
                  count: widget.foodList.length,
                  activeColor: context.primary,
                  inactiveColor: context.secondaryTextColor,
                  dotHeight: 6,
                );
              })
      ],
    );
  }

  Widget cardDesign(Food food) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: context.screenWidth * 0.6,
        height: context.screenHeight * 0.18,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: food.image == null ? null : DecorationImage(image: NetworkImage(food.image!), fit: BoxFit.fill)),
        child: Text(food.image == null ? food.name : ""),
      ),
    );
  }
}