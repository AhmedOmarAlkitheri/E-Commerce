import 'package:flutter/material.dart';

class TextFrmFieldPassword extends StatelessWidget {
  TextFrmFieldPassword(
      {super.key,
      required this.labelText,
      required this.prefixIcon,
      required this.suffixIcon,
      required this.controller,
      this.obscureText = true,
      this.validator});
  String labelText;
  TextEditingController? controller;
  Widget? suffixIcon, prefixIcon;
  bool obscureText;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        //  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        prefixIcon: prefixIcon,
        // hintText: "كلمة السر",
        labelText: labelText,
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
    );
  }
}
