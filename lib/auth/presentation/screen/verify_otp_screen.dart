import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jasbe/auth/presentation/screen/greeting_screen.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/shared/presentation/components/back_button.dart';
import 'package:jasbe/shared/presentation/screens/main_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  showLoading() => setState(() => loading = true);
  hideLoading() => setState(() => loading = false);

  final pinCodeController = TextEditingController();

  Future<void> verifyCode() async {
    showLoading();

    toast("#Verify Code ${pinCodeController.text}");
    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(() => const GreetingScreen());

    hideLoading();
  }

  Future<void> resendCode() async {
    toast("#Send Code");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonArrow(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "Enter your code",
              textScaleFactor: 1.8,
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),

            // Des
            const Text("Enter the code we just sent to your mobile"),
            const SizedBox(height: 30),

            // Pin Input
            PinCodeTextField(
              appContext: context,
              length: 4,
              animationType: AnimationType.scale,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                borderWidth: 1,
                inactiveColor: context.borderColor,
                activeColor: Colors.lightBlue,
                disabledColor: Colors.lightBlue,
                selectedColor: Colors.lightBlue,
                selectedFillColor: context.backgroundColor,
                activeFillColor: context.backgroundColor,
                inactiveFillColor: context.backgroundColor,
                fieldHeight: MediaQuery.of(context).size.width * 0.15,
                fieldWidth: MediaQuery.of(context).size.width * 0.15,
              ),
              cursorColor: Colors.lightBlue,
              cursorWidth: 1.2,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              controller: pinCodeController,
              keyboardType: TextInputType.number,
              onChanged: (String value) {},
            ),

            // Resend Code
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                    minimumSize: const Size(100, 30),
                    foregroundColor: Colors.lightBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                onPressed: resendCode,
                child: const Text(
                  "Resend code",
                  textScaleFactor: 1.0,
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.1),

            // Verify Button
            Center(
              child: loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.foregroundColor, minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 50)),
                      onPressed: verifyCode,
                      child: const Text("Next"),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
