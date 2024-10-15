import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jasbe/auth/controller/auth_controller.dart';
import 'package:jasbe/auth/helper/form_field_utils.dart';
import 'package:jasbe/auth/model/user.dart';
import 'package:jasbe/auth/presentation/screen/forgot_password_screen.dart';
import 'package:jasbe/auth/presentation/screen/verify_otp_screen.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/shared/presentation/screens/main_screen.dart';

class SignInContent extends StatefulWidget {
  const SignInContent({super.key});

  @override
  State<SignInContent> createState() => SignInContentState();
}

class SignInContentState extends State<SignInContent> {
  bool loading = false;
  showLoading() => setState(() => loading = true);
  hideLoading() => setState(() => loading = false);

  final validatorKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool inVisiblePassword = true;

  Future<void> submit() async {
    if (validatorKey.currentState!.validate()) {
      showLoading();

      await Future.delayed(const Duration(seconds: 2));
      toast("#Log In");
      Get.to(() => const VerifyCodeScreen());

      hideLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),

          // Greeting
          Text(
            "Welcome back,",
            textScaleFactor: 1.8,
            style: TextStyle(color: context.foregroundColor),
          ),

          const SizedBox(height: 5),

          // Username
          Text(
            "Lenny",
            textScaleFactor: 1.8,
            style: TextStyle(color: context.foregroundColor, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Form(
            key: validatorKey,
            child: Column(
              children: [
                // Email Input
                TextFormField(
                  cursorWidth: 1.2,
                  cursorColor: context.foregroundColor,
                  controller: emailController,
                  decoration: getJasbeFieldStyle(context, "Email"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  validator: emailValidate,
                ),
                const SizedBox(height: 20),

                // Password Input
                TextFormField(
                  controller: passwordController,
                  cursorWidth: 1.2,
                  cursorColor: context.foregroundColor,
                  decoration: getJasbeFieldStyle(context, "Password",
                      suffix: passwordVisibilityWidget(context, inVisiblePassword, (value) {
                        setState(() {
                          inVisiblePassword = value;
                        });
                      })),
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.password],
                  validator: passwordValidate,
                  obscureText: inVisiblePassword,
                ),
                const SizedBox(height: 10),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: const Size(100, 30),
                        foregroundColor: Colors.lightBlue,
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    child: const Text(
                      "Forgot password?",
                      textScaleFactor: 1.0,
                    ),
                    onPressed: () {
                      Get.to(() => const ForgotPasswordScreen(), transition: Transition.downToUp);
                    },
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),

          // Sign In or Loading
          loading
              ? const Center(child: CircularProgressIndicator())
              : Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: context.foregroundColor, minimumSize: const Size(150, 50)),
                    onPressed: submit,
                    child: const Text("Sign In"),
                  ),
                ),
        ],
      ),
    );
  }
}
