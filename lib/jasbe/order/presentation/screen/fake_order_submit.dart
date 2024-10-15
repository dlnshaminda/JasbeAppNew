import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/order/model/venue.dart';
import 'package:jasbe/main.dart';
import 'package:jasbe/shared/presentation/screens/main_screen.dart';

class FakeOrderSubmit extends StatefulWidget {
  const FakeOrderSubmit({super.key, required this.venue});

  final Venue venue;

  @override
  State<FakeOrderSubmit> createState() => _FakeOrderSubmitState();
}

class _FakeOrderSubmitState extends State<FakeOrderSubmit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(context.assets.currentLocationBackground))),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Show Map Here

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: context.screenWidth,
                height: context.screenHeight * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.backgroundColor,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, -1),
                      blurRadius: 5,
                      color: Colors.black12,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: context.screenHeight * 0.23,
                      width: context.screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        image: DecorationImage(image: AssetImage(context.assets.sampleVenue), fit: BoxFit.fill),
                      ),
                    ),
                    placeHold(0, 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        placeHold(20, 0),
                        Icon(
                          IconlyLight.location,
                          color: context.primary,
                          size: 40,
                        ),
                        placeHold(15, 0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.venue.name,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              widget.venue.address,
                              textScaleFactor: 1.0,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              widget.venue.phone,
                              textScaleFactor: 1.0,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            Text(widget.venue.peroid, style: TextStyle(color: context.primary, fontWeight: FontWeight.w500))
                          ],
                        )
                      ],
                    ),
                    placeHold(0, 15),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(context.screenWidth * 0.5, 0),
                            textStyle: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            cartController.setVenue(widget.venue);
                            Get.offAll(() => const MainScreen());
                          },
                          child: const Text("Order")),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
