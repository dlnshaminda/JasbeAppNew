import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jasbe/auth/presentation/components/dot_indicator.dart';
import 'package:jasbe/auth/presentation/screen/signing_screen.dart';
import 'package:jasbe/common/functions.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final boardController = PageController(initialPage: 0, keepPage: true);

  int index = 0;

  @override
  void initState() {
    super.initState();
    listenBoard();
  }

  listenBoard() {
    boardController.addListener(() {
      final screenWidth = MediaQuery.of(context).size.width;
      int boardNumber = (boardController.offset / screenWidth).ceil();
      setState(() {
        index = boardNumber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        placeHold(0, context.screenHeight * 0.1),

        // App Logo
        Image.asset(context.assets.appLogo, width: 100),

        placeHold(0, context.screenHeight * 0.07),

        // Board Slide
        SizedBox(
          height: context.screenHeight * 0.5,
          child: Stack(children: [
            PageView(
              controller: boardController,
              children: const [
                BoardOne(),
                BoardTwo(),
                BoardThree(),
              ],
            ),
            AnimatedPositioned(
              top: seedOneRenderPositionOnIndex(index).dy,
              left: seedOneRenderPositionOnIndex(index).dx,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: AnimatedOpacity(
                  opacity: index == 2 ? 1 : 0.5,
                  duration: const Duration(milliseconds: 400),
                  child: Image.asset(context.assets.threeCoffeeSeeds, height: 100, width: 100)),
            ),
            AnimatedPositioned(
              top: seedTwoRenderPositionOnIndex(index).dy,
              right: seedTwoRenderPositionOnIndex(index).dx,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: AnimatedOpacity(
                  opacity: index == 2 ? 1 : 0.5,
                  duration: const Duration(milliseconds: 400),
                  child: Image.asset(context.assets.fourCoffeeSeeds, height: 100, width: 100)),
            ),
          ]),
        ),

        placeHold(0, 20),

        // Dot Indicator
        DotIndicatorWidget(
          currentIndex: index,
          count: 3,
          activeColor: context.primary,
          inactiveColor: context.secondaryTextColor,
        ),

        // Board Controller Button
        Expanded(child: Center(child: getStartedButton())),

        // Already Account Button
        alreadyAccount(),
        const SizedBox(height: 30),
      ],
    ));
  }

  Widget getStartedButton() {
    final last = index == 2;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        minimumSize: Size(MediaQuery.of(context).size.width * 0.65, 50),
        backgroundColor: last ? context.primary : context.foregroundColor,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (last) {
          Get.to(() => const SigningScreen());
          return;
        }

        // Animate Board
        boardController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
      },
      child: Text(last ? "Get Started" : "Next", textScaleFactor: 1.2),
    );
  }

  Widget alreadyAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account ?",
          textScaleFactor: 1.0,
        ),
        const SizedBox(width: 5),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size(80, 35),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          ),
          onPressed: () => Get.to(() => const SigningScreen()),
          child: const Text("Log In"),
        ),
      ],
    );
  }

  Offset seedOneRenderPositionOnIndex(int index) {
    switch (index) {
      case 0:
        return const Offset(-100, 100);
      case 1:
        return const Offset(0, 20);
      case 2:
        return const Offset(10, 80);
      default:
        return const Offset(0, 100);
    }
  }

  Offset seedTwoRenderPositionOnIndex(int index) {
    switch (index) {
      case 0:
        return const Offset(-100, 0);
      case 1:
        return const Offset(10, 100);
      case 2:
        return const Offset(0, 80);
      default:
        return const Offset(0, 100);
    }
  }
}

/// Board One Widget
class BoardOne extends StatelessWidget {
  const BoardOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            context.assets.coffeeMaker,
            height: 200,
            width: 200,
          ),
        ),
        Text(
          "Good Coffee",
          textScaleFactor: 1.7,
          style: TextStyle(
            color: context.primary,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(color: context.primary.withOpacity(0.4), blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
        ),
        Text(
          "Good Moods",
          textScaleFactor: 1.7,
          style: TextStyle(
            color: context.foregroundColor,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(color: context.foregroundColor.withOpacity(0.4), blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.12),
          child: const Text(
            "\"Fuel up with our delicious coffee and conquer the day.\"",
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

/// Board Two Widget
class BoardTwo extends StatelessWidget {
  const BoardTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            context.assets.coffeeMaker,
            height: 200,
            width: 200,
          ),
        ),
        Text(
          "Better Relax",
          textScaleFactor: 1.7,
          style: TextStyle(
            color: context.primary,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(color: context.primary.withOpacity(0.4), blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
        ),
        Text(
          "Chill Stress",
          textScaleFactor: 1.7,
          style: TextStyle(
            color: context.foregroundColor,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(color: context.foregroundColor.withOpacity(0.4), blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.12),
          child: const Text(
            "\"Deserunt voluptate dolor nulla labore commodo esse qui.\"",
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

/// Board Three Widget
class BoardThree extends StatelessWidget {
  const BoardThree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            context.assets.coffeeMaker,
            height: 200,
            width: 200,
          ),
        ),
        Text(
          "Your Delight",
          textScaleFactor: 1.7,
          style: TextStyle(
            color: context.primary,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(color: context.primary.withOpacity(0.4), blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
        ),
        Text(
          "Join Now",
          textScaleFactor: 1.7,
          style: TextStyle(
            color: context.foregroundColor,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(color: context.foregroundColor.withOpacity(0.4), blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.12),
          child: const Text(
            "\"Officia cillum officia ut sit veniam consequat est pariatur occaecat commodo non.\"",
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
