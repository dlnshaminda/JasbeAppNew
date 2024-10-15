import 'package:flutter/material.dart';

class DotIndicatorWidget extends StatelessWidget {
  const DotIndicatorWidget(
      {Key? key,
      required this.currentIndex,
      required this.count,
      required this.activeColor,
      required this.inactiveColor,
      this.activeDotWidth = 15,
      this.dotHeight = 7})
      : super(key: key);

  final int currentIndex;
  final int count;
  final Color activeColor;
  final Color inactiveColor;
  final double activeDotWidth;
  final double dotHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(count, (index) {
          return Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transformAlignment: Alignment.centerRight,
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: currentIndex == index ? activeColor : inactiveColor),
                height: dotHeight,
                width: currentIndex == index ? activeDotWidth : dotHeight,
              ),
              if (index != count - 1) const SizedBox(width: 10)
            ],
          );
        })
      ],
    );
  }
}
