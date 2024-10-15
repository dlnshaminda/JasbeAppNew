import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jasbe/auth/controller/auth_controller.dart';
import 'package:jasbe/auth/helper/form_field_utils.dart';
import 'package:jasbe/auth/model/user.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/shared/presentation/screens/main_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignUpContent extends StatefulWidget {
  const SignUpContent({super.key});

  @override
  State<SignUpContent> createState() => SignUpContentState();
}

class SignUpContentState extends State<SignUpContent> {
  bool loading = false;
  showLoading() => setState(() => loading = true);
  hideLoading() => setState(() => loading = false);

  final validatorKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool inVisiblePassword = true;
  bool agreeTrems = false;

  String? _nameValidate(String? value) {
    if (value != null && value.isEmpty) return "Name is requried";
    return null;
  }

  String? _emailValidate(String? value) {
    if (value != null && value.isEmpty) return "Email is requried";
    return null;
  }

  String? _phoneValidate(String? value) {
    if (value != null && value.isEmpty) return "Phone number is requried";
    return null;
  }

  String? _passwordValidate(String? value) {
    if (value != null && value.isEmpty) return "Password is requried";
    return null;
  }

  Future<void> submit() async {
    if (validatorKey.currentState!.validate()) {
      if (!agreeTrems) {
        toast("Please agree the Terms");
        return;
      }
      showLoading();

      await Future.delayed(const Duration(seconds: 2));
      toast("#Sign Up");
      AuthController.instance.setUserData(
        JasbeUser(userId: "1", name: nameController.text, email: emailController.text, phone: phoneController.text, profile: null),
      );
      Get.offAll(() => const MainScreen());

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
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),

          // Greeting
          Text(
            "Hello there,",
            textScaleFactor: 1.8,
            style: TextStyle(color: context.foregroundColor, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 5),

          // Description
          Text(
            "Let's get start our quick and easy sign-up process.",
            textScaleFactor: 1.2,
            style: TextStyle(color: context.textColor),
          ),

          const SizedBox(height: 30),

          Form(
            key: validatorKey,
            child: Column(
              children: [
                // Name Input
                TextFormField(
                  controller: nameController,
                  cursorColor: context.foregroundColor,
                  cursorWidth: 1.2,
                  decoration: getJasbeFieldStyle(context, "Name"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  autofillHints: const [AutofillHints.name],
                  validator: _nameValidate,
                ),
                const SizedBox(height: 20),

                // Email Input
                TextFormField(
                  controller: emailController,
                  cursorColor: context.foregroundColor,
                  cursorWidth: 1.2,
                  decoration: getJasbeFieldStyle(context, "Email"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  validator: _emailValidate,
                ),
                const SizedBox(height: 20),

                // Phone Input
                TextFormField(
                  controller: phoneController,
                  cursorColor: context.foregroundColor,
                  cursorWidth: 1.2,
                  decoration: getJasbeFieldStyle(context, "Phone Number"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  validator: _phoneValidate,
                ),
                const SizedBox(height: 20),

                // Phone Input
                TextFormField(
                  controller: passwordController,
                  cursorColor: context.foregroundColor,
                  cursorWidth: 1.2,
                  decoration: getJasbeFieldStyle(context, "Password",
                      suffix: passwordVisibilityWidget(context, inVisiblePassword, (value) {
                        setState(() {
                          inVisiblePassword = value;
                        });
                      })),
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: const [AutofillHints.newPassword],
                  validator: _passwordValidate,
                  obscureText: inVisiblePassword,
                ),
                const SizedBox(height: 20),

                // Agree Terms
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                        value: agreeTrems,
                        onChanged: (value) {
                          setState(() {
                            agreeTrems = value!;
                          });
                        },
                        side: const BorderSide(width: 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("By clicking this button, I agree to the Jasbe terms", textScaleFactor: 1.0),
                          SizedBox(
                            height: 30,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: const Size(double.minPositive, 30),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                                ),
                                onPressed: () {
                                  launchUrlString("https://www.google.com", mode: LaunchMode.externalApplication);
                                },
                                child: const Text(
                                  "Term of Use",
                                  textScaleFactor: 0.9,
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),

          // Confirm or Loading
          loading
              ? const Center(child: CircularProgressIndicator())
              : Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: context.foregroundColor, minimumSize: const Size(150, 50)),
                    onPressed: submit,
                    child: const Text("Confirm"),
                  ),
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
