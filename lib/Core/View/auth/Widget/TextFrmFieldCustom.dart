import 'package:flutter/material.dart';

class TextFrmFieldCustom extends StatelessWidget {
  TextFrmFieldCustom({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.controller, 
    this.validator
  });
  String labelText;
  Widget? prefixIcon;
  TextEditingController? controller;
  String? Function(String?)? validator ;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: ,
      validator: validator ,
      controller: controller,
     
      decoration: InputDecoration(
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: prefixIcon, // Icon(Icons.send_rounded),

          // hintText: "البريد الالكتروني",
          labelText: labelText),
    );
  }
}
