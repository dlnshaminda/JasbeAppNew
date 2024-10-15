import 'package:flutter/material.dart';
import 'package:jasbe/common/functions.dart';

InputDecoration getJasbeFieldStyle(BuildContext context, String hint, {Widget? prefix, Widget? suffix,double? radius}) {
  final border = OutlineInputBorder(borderRadius: BorderRadius.circular(radius??10), borderSide: BorderSide(color: context.borderColor));
  final focusBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(radius??10), borderSide: const BorderSide(color: Colors.lightBlue));

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

Widget passwordVisibilityWidget(BuildContext context, bool visible, Function(bool value) onChanged) {
  return GestureDetector(
    onTap: () {
      visible = !visible;
      onChanged(visible);
    },
    child: Icon(visible ? Icons.visibility_off : Icons.visibility, color: context.secondaryTextColor, size: 20),
  );
}

String? emailValidate(String? value) {
  if (value != null && value.isEmpty) return "Email is requried";
  return null;
}

String? passwordValidate(String? value) {
  if (value != null && value.isEmpty) return "Password is requried";
  return null;
}
