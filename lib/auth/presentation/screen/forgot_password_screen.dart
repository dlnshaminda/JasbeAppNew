import 'package:flutter/material.dart';
import 'package:jasbe/auth/helper/form_field_utils.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/shared/presentation/components/back_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _validatorKey = GlobalKey<FormFieldState>();

  final phoneController = TextEditingController();

  String? _phoneValidate(String? value) {
    if (value != null && value.isEmpty) return "Please fill a number";
    return null;
  }

  Future<void> sendCode() async {
    if (_validatorKey.currentState!.validate()) {
      toast("#Send Code");
    }
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
              "Forgot Password",
              textScaleFactor: 1.8,
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),

            // Description
            const Text("Enter the phone number associated with your account and we'll send a code to reset your password"),
            const SizedBox(height: 20),

            // Phone Number Input
            TextFormField(
              controller: phoneController,
              key: _validatorKey,
              cursorColor: context.foregroundColor,
              cursorWidth: 1.2,
              decoration: getJasbeFieldStyle(context, "Phone Number"),
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.phone,
              autofillHints: const [AutofillHints.telephoneNumber],
              validator: _phoneValidate,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),

            // Sign In or Loading
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: context.foregroundColor, minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 50)),
                onPressed: sendCode,
                child: const Text("Sign In"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
