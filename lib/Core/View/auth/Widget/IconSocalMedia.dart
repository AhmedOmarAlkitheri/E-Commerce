

import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:flutter/material.dart';

class IconSocalMedia extends StatelessWidget {
   IconSocalMedia({
    super.key,
    required this.onPressed,
    required this.pathImage,
  });
Function() onPressed ;
String pathImage;
  @override
  Widget build(BuildContext context) {
    return 
        Container(
          decoration: BoxDecoration(
            
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color:  AppColor.grey,)),
          child: IconButton(
              onPressed: onPressed,
              icon: Image(
                image: AssetImage(pathImage),
                height: SizesConstant.iconMd,
                width: SizesConstant.iconMd,
              )),
        ) 
     ;
  }
}
