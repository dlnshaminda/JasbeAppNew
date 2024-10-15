import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:jasbe/auth/helper/form_field_utils.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/order/helper/card_formatter.dart';
import 'package:jasbe/shared/presentation/components/back_button.dart';

class CardAddScreen extends StatefulWidget {
  const CardAddScreen({super.key});

  @override
  State<CardAddScreen> createState() => _CardAddScreenState();
}

class _CardAddScreenState extends State<CardAddScreen> {
  final validatorKey = GlobalKey<FormFieldState>();

  final labelController = TextEditingController();
  final cardNumberController = TextEditingController();
  final cardHolderController = TextEditingController();
  final expiryController = TextEditingController();
  final cvcController = TextEditingController();

  bool useDefaultCard = false;

  @override
  void initState() {
    super.initState();
  }

  String? _emptyValidate(String? value, String message) {
    if (value != null && value.isEmpty) return message;
    return null;
  }

  String cardFormatter(String newValue) {
    String enteredData = newValue;
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < enteredData.length; i++) {
      buffer.write(enteredData[i]);
      int index = i + 1;
      if (index % 4 == 0 && enteredData.length != index) {
        buffer.write(" ");
      }
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonArrow(),
        title: const Text("Add New Card"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: validatorKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff323232),
                  ),
                  height: context.screenHeight * 0.25,
                  width: double.maxFinite,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Image.asset(context.assets.masterLogo, height: 50, width: 60),
                      ),
                      Positioned(
                        bottom: 40,
                        left: 10,
                        child: Text(
                          cardHolderController.text,
                          style: const TextStyle(color: Colors.white54),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          cardFormatter(cardNumberController.text),
                          textScaleFactor: 1.3,
                          style: const TextStyle(color: Colors.white54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              placeHold(0, 30),
              TextFormField(
                controller: labelController,
                cursorColor: context.foregroundColor,
                cursorWidth: 1.2,
                decoration: getJasbeFieldStyle(context, "Card label (Personal etc.)"),
                textInputAction: TextInputAction.next,
                validator: (value) => _emptyValidate(value, "Label is required"),
              ),
              const SizedBox(height: 20),

              // Email Input
              TextFormField(
                controller: cardHolderController,
                cursorColor: context.foregroundColor,
                cursorWidth: 1.2,
                decoration: getJasbeFieldStyle(context, "Card holder name"),
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {});
                },
                validator: (value) => _emptyValidate(value, "Holder name is required"),
              ),
              const SizedBox(height: 20),

              // Phone Input
              TextFormField(
                controller: cardNumberController,
                cursorColor: context.foregroundColor,
                cursorWidth: 1.2,
                decoration: getJasbeFieldStyle(context, "Card number"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                maxLength: 16,
                // inputFormatters: [FilteringTextInputFormatter.digitsOnly, CreditCardNumberFormater(), LengthLimitingTextInputFormatter(19)],
                onChanged: (value) {
                  setState(() {});
                },
                validator: (value) => _emptyValidate(value, "Card Number is required"),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.screenWidth * 0.4,
                    child: TextFormField(
                      controller: expiryController,
                      cursorColor: context.foregroundColor,
                      cursorWidth: 1.2,
                      decoration: getJasbeFieldStyle(context, "Expiry"),
                      textInputAction: TextInputAction.next,
                      validator: (value) => _emptyValidate(value, "Expiry is required"),
                    ),
                  ),
                  SizedBox(
                    width: context.screenWidth * 0.4,
                    child: TextFormField(
                      controller: cvcController,
                      cursorColor: context.foregroundColor,
                      cursorWidth: 1.2,
                      decoration: getJasbeFieldStyle(context, "CVC"),
                      textInputAction: TextInputAction.next,
                      validator: (value) => _emptyValidate(value, "CVC is required"),
                    ),
                  ),
                ],
              ),

              // Default Card Save
              Row(
                children: [
                  Checkbox(
                    value: useDefaultCard,
                    onChanged: (value) {
                      setState(() {
                        useDefaultCard = value!;
                      });
                    },
                    side: const BorderSide(width: 1),
                    activeColor: context.foregroundColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        useDefaultCard = !useDefaultCard;
                      });
                    },
                    child: Text("Set as default payment card", textScaleFactor: 1.0),
                  )
                ],
              ),

              placeHold(0, 20),

              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: context.foregroundColor,
                      minimumSize: Size(context.screenWidth * 0.5, 40),
                    ),
                    onPressed: () {
                      if (validatorKey.currentState!.validate()) {}
                    },
                    child: const Text("Save")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
