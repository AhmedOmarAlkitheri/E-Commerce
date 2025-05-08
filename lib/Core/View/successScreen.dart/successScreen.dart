import 'package:ecommerce_app_client/Core/View/auth/Widget/CostumButton.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/style/SpaceStyle.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Successscreen extends StatelessWidget {
   const Successscreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image, title, subTitle;
 final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: Spacestyle.paddingWithAppbarHeight * 2,
            child: Column(children: [
               Lottie.asset(image ,  width: Helperfunction.screenWidth() * 0.6,),
            
              SizedBox(
                height: SizesConstant.spaceBtwSection,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizesConstant.spaceBtwItem,
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizesConstant.spaceBtwSection,
              ),
              SizedBox(
                width: double.infinity,
                child: CostumButton(
                 nameButton: "استمر",
                  onPressed: onPressed, 
                ),
              ),
            ])),
      ),
    );
  }
}
