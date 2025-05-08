import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    this.isNetWorkImage = false
  });

  final String image, title, subTitle;
  final bool isNetWorkImage ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizesConstant.defaultSpace),
      child: Column(
        children: [
          Image(
            width: Helperfunction.screenWidth() * 0.8,
            height: Helperfunction.screenHeight() * 0.6,
            image:isNetWorkImage ?
            NetworkImage(image)
          :  AssetImage(image),
          ), // Image
          Text(title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center),
          SizedBox(height: SizesConstant.spaceBtwItem),
          Text(subTitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center),
        ],
      ), // Column
    ); // Padding
  }
}
