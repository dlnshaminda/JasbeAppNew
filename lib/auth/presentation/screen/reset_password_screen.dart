import 'package:flutter/material.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/shared/presentation/components/back_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool loading = false;
  showLoading() => setState(() => loading = true);
  hideLoading() => setState(() => loading = false);

  final _validatorKey = GlobalKey<FormState>();

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool inVisiblePassword = true;

  InputDecoration getInputDecoration(String hint, {Widget? prefix, Widget? suffix}) {
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: context.borderColor));
    final focusBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.lightBlue));

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

  Widget passwordVisibilityWidget() {
    return GestureDetector(
      onTap: () {
        setState(() {
          inVisiblePassword = !inVisiblePassword;
        });
      },
      child: Icon(inVisiblePassword ? Icons.visibility_off : Icons.visibility, color: context.secondaryTextColor, size: 20),
    );
  }

  String? _passwordValidate(String? value) {
    if (value != null && value.isEmpty) return "Please enter a password";
    return null;
  }

  String? _confirmPasswordValidate(String? value) {
    if (value != null && value.isEmpty) {
      return "Confirm new password";
    } else if (newPasswordController.text != confirmPasswordController.text) {
      return "Passwords not matched each other !";
    }
    return null;
  }

  Future<void> changePassword() async {
    if (_validatorKey.currentState!.validate()) {
      showLoading();
      toast("#Change Password");
      await Future.delayed(const Duration(seconds: 2));
      hideLoading();
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
              "Reset Password",
              textScaleFactor: 1.8,
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),

            // Description
            const Text("Enter a new password"),
            const SizedBox(height: 20),

            Form(
              key: _validatorKey,
              child: Column(
                children: [
                  // New Password Input
                  TextFormField(
                    controller: newPasswordController,
                    decoration: getInputDecoration("New Password", suffix: passwordVisibilityWidget()),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: const [AutofillHints.newPassword],
                    validator: _passwordValidate,
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password Input
                  TextFormField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    decoration: getInputDecoration("Re-enter new password"),
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: const [AutofillHints.newPassword],
                    validator: _confirmPasswordValidate,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),

            // Change or Loading
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: context.foregroundColor, minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 50)),
                onPressed: changePassword,
                child: const Text("Change"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
