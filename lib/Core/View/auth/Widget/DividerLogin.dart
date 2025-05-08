import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';

class DividerLogin extends StatelessWidget {
   DividerLogin({
    super.key,
    required this.title,
  });
  String title;
  @override
  Widget build(BuildContext context) {
     final dark =  Helperfunction.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
             color: dark ? AppColor.darkGrey :  AppColor.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(title , style:   Theme.of(context).textTheme.labelMedium,),
        Flexible(
          child: Divider(
            color: Colors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
