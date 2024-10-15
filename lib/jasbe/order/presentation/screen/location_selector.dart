import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:jasbe/auth/helper/form_field_utils.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/order/helper/data_seed.dart';
import 'package:jasbe/jasbe/order/model/venue.dart';
import 'package:jasbe/jasbe/order/presentation/screen/fake_order_submit.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key, this.uesCurrentLocation = false});

  final bool uesCurrentLocation;

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  final yourLocationController = TextEditingController();
  final nearestLocationController = TextEditingController();

  bool expand = true;

  InputDecoration getFieldStyle(BuildContext context, String hint, {Widget? prefix, Widget? suffix}) {
    final border = UnderlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: context.borderColor));
    final focusBorder = UnderlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.lightBlue));

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
      prefixIcon: prefix,
      suffixIcon: suffix,
    );
  }

  @override
  void initState() {
    initValues();
    super.initState();
  }

  void initValues() {
    yourLocationController.text = "2972 Westheimer Rd. Fitzroy St";
    nearestLocationController.text = "Jasbe Fitzroy\nDistance: 3km\n29 Ormond St.Fitzroy St";
  }

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

            if (!widget.uesCurrentLocation)
              Positioned(
                top: context.screenHeight * 0.2,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    placeHold(0, context.screenHeight * 0.05),
                    const Text(
                      "Select Location",
                      textScaleFactor: 1.8,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const Text('Select from locations around you'),
                    placeHold(0, context.screenHeight * 0.1),
                  ],
                ),
              ),

            if (!widget.uesCurrentLocation) availableVenues(),

            // Information Sheet
            if (widget.uesCurrentLocation)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  transform: Matrix4.translationValues(0, expand ? 0 : context.screenHeight * 0.43, 0),
                  duration: const Duration(milliseconds: 400),
                  width: context.screenWidth,
                  height: context.screenHeight * 0.43 + MediaQuery.of(context).viewInsets.bottom,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: context.backgroundColor, boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, -1),
                      blurRadius: 5,
                      color: Colors.black12,
                    )
                  ]),
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      placeHold(0, 10),
                      const Text(
                        "The nearest venue to you is:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      placeHold(0, 10),
                      Text(
                        "Your location",
                        textScaleFactor: 1.0,
                        style: TextStyle(color: context.secondaryTextColor),
                      ),
                      TextField(
                        controller: yourLocationController,
                        decoration: getFieldStyle(context, "Enter Your Location"),
                        cursorColor: context.foregroundColor,
                        cursorWidth: 1.3,
                      ),
                      placeHold(0, 15),
                      Text(
                        "Your closest venue is",
                        textScaleFactor: 1.0,
                        style: TextStyle(color: context.secondaryTextColor),
                      ),
                      TextField(
                        controller: nearestLocationController,
                        decoration: getFieldStyle(context, "Enter Your Location"),
                        cursorColor: context.foregroundColor,
                        cursorWidth: 1.3,
                        maxLines: null,
                      ),
                      placeHold(0, 10),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(context.screenWidth * 0.5, 0),
                              textStyle: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              const venue = Venue(
                                name: "Jasbe Fitzroy",
                                detail: "29 Ormond St.Fitzroy St",
                                peroid: "09:00 AM - 10:00 PM Daily",
                                location: "-1,-1",
                                address: "211 Oromond Street, Fitzroy",
                                phone: "03 2322 3312",
                              );
                              Get.to(() => const FakeOrderSubmit(venue: venue));
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

  Widget availableVenues() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: context.screenHeight * 0.5,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          children: [
            ...sampleVenues.map((shop) {
              return _LocationCard(
                title: shop.name,
                peroid: shop.peroid,
                detail: shop.detail,
                distance: 3.2,
                onTap: () => Get.to(() => FakeOrderSubmit(venue: shop)),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    super.key,
    required this.title,
    required this.peroid,
    required this.detail,
    required this.distance,
    this.onTap,
  });

  final String title;
  final String peroid;
  final String detail;
  final double distance;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Colors.black12)),
        margin: EdgeInsets.only(bottom: context.screenHeight * 0.05),
        color: context.backgroundColor,
        child: SizedBox(
          height: context.screenHeight * 0.22,
          child: Column(
            children: [
              Container(
                height: context.screenHeight * 0.12,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: context.primary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultTextStyle(
                          style: TextStyle(color: context.secondaryTextColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(peroid, textScaleFactor: 1, maxLines: 1, overflow: TextOverflow.ellipsis),
                              Text(detail, textScaleFactor: 1, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(IconlyLight.location, color: context.primary),
                            placeHold(0, 10),
                            Text("$distance Km", style: TextStyle(color: context.primary)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
