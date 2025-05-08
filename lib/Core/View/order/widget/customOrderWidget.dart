import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:flutter/material.dart';

class CustomOrderWidget extends StatelessWidget {
  const CustomOrderWidget({super.key, required this.icon, required this.titleStyle, required this.subTitleStyle, required this.title, required this.subTitle});
  final IconData icon;
  final  dynamic  titleStyle ,subTitleStyle ;
  final String title ,subTitle;

 
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          SizedBox(
            width: SizesConstant.spaceBtwItem / 2,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [  
                Text(title, style: titleStyle),
                Text( subTitle, style: subTitleStyle  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
