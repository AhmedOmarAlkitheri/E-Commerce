import 'package:ecommerce_app_client/Core/View/auth/register/register.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/CostumButton.dart';
import 'package:ecommerce_app_client/Core/View/auth/login/login.dart';
import 'package:ecommerce_app_client/Core/View/successScreen.dart/successScreen.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                
                Get.offAllNamed("/Createaccount");
              },
              icon: Icon(Icons.close_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizesConstant.defaultSpace),
          child: Column(
            children: [
              Image(
                image: AssetImage(ImagesConstant.logo),
                width: Helperfunction.screenWidth() * 0.6,
              ),
              SizedBox(
                height: SizesConstant.spaceBtwSection,
              ),
              Text(
                "",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizesConstant.spaceBtwItem,
              ),
              Text(
                "a.o.a.770294548@gmail.com",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizesConstant.spaceBtwItem,
              ),
              Text(
                "",
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
                  onPressed: () {
                    Get.offAllNamed(
                      "/Successscreen",
                      arguments: {
                        'image': ImagesConstant.successfully_done,
                        'title': 'Your Title Here',
                        'subTitle': 'Your Subtitle Here',
                        'onPressed': () {
                          Get.offAllNamed("/Login");
                        },
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: SizesConstant.spaceBtwItem,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  child: Text("إعادة ارسال الأيميل"),
                  onPressed: () {  Get.offAllNamed("/Createaccount"); 
                  
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
