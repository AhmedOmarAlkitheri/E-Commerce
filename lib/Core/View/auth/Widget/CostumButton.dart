import 'package:flutter/material.dart';

class CostumButton extends StatelessWidget {
   CostumButton({
    super.key,
    required this.nameButton,
    required this.onPressed,
  });
  Function() onPressed;
  String nameButton;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onPressed,
          
            child: Text(nameButton)));
    
  }
}
