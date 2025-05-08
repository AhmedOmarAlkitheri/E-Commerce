import 'dart:async';

import 'package:ecommerce_app_client/Core/View/auth/register/verify_email.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/CostumButton.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/DividerLogin.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/IconSocalMedia.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/TextFrmFieldCustom.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/TextFrmFieldPassword.dart';
import 'package:ecommerce_app_client/Core/ViewModel/auth/authenticationVM.dart';

import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constants/Colors.dart';
import '../../../../global/validation/validation.dart';
import '../../../server/authController.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthController authController =
      Get.put(AuthController(useFirebase: false));
  Authenticationvm authenticationController = Get.put(Authenticationvm());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(
        showBackArrow: true,
        onPressed: () => Get.offAllNamed("/Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizesConstant.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "مرحباً بك في المتجر",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: SizesConstant.spaceBtwSection,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFrmFieldCustom(
                      controller: authenticationController.nameUserController,
                      validator: (p0) => InputValidator.validateArabicName(p0),
                      labelText: "اسم المستخدم",
                      prefixIcon: Transform.scale(
                        scale: 0.5,
                        child: Image.asset(
                          ImagesConstant.user,
                          color: AppColor.greyIcon,
                          height: SizesConstant.iconSm,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizesConstant.spaceBtwInputField,
                    ),
                    TextFrmFieldCustom(
                      controller: authenticationController.emailController,
                      validator: (p0) => InputValidator.validateEmail(p0),
                      labelText: "البريد الإلكتروني",
                      prefixIcon: Transform.scale(
                        scale: 0.5,
                        child: Image.asset(
                          ImagesConstant.mail_1,
                          color: AppColor.greyIcon,
                          height: SizesConstant.iconSm,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizesConstant.spaceBtwInputField,
                    ),
                    TextFrmFieldCustom(
                      controller: authenticationController.phoneController,
                      validator: (p0) => InputValidator.validatePhoneNumber(p0),
                      labelText: "رقم الجوال",
                      prefixIcon: Transform.scale(
                        scale: 0.5,
                        child: Image.asset(
                          ImagesConstant.phone_book,
                          color: AppColor.greyIcon,
                          height: SizesConstant.iconSm,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizesConstant.spaceBtwInputField,
                    ),
                    Obx(
                      () => TextFrmFieldPassword(
                        obscureText: authenticationController.obscureText.value,
                        controller: authenticationController.passwordController,
                        validator: (p0) => InputValidator.validatePassword(p0),
                        labelText: "كلمة المرور",
                        prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: Image.asset(
                            ImagesConstant.padlock,
                            color: AppColor.greyIcon,
                            height: SizesConstant.iconSm,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            authenticationController.obscureText.value =
                                !authenticationController.obscureText.value;
                          },
                          icon: SizedBox(
                            height: 25,
                            child: Image.asset(
                              authenticationController.obscureText.value
                                  ? ImagesConstant.hide
                                  : ImagesConstant.show,
                              color: AppColor.greyIcon,
                              height: SizesConstant.iconSm,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizesConstant.spaceBtwInputField,
                    ),
                    Obx(
                      () => TextFrmFieldPassword(
                        obscureText: authenticationController.obscureText.value,
                        controller:
                            authenticationController.confirmPasswordController,
                        validator: (p0) => InputValidator.validatePassword(p0),
                        labelText: "تأكيد كلمة المرور",
                        prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: Image.asset(
                            ImagesConstant.padlock,
                            color: AppColor.greyIcon,
                            height: SizesConstant.iconSm,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            authenticationController.obscureText.value =
                                !authenticationController.obscureText.value;
                          },
                          icon: SizedBox(
                            height: 25,
                            child: Image.asset(
                              authenticationController.obscureText.value
                                  ? ImagesConstant.hide
                                  : ImagesConstant.show,
                              color: AppColor.greyIcon,
                              height: SizesConstant.iconSm,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizesConstant.spaceBtwSection,
                    ),
                    CostumButton(
                      nameButton: "إنشاء حساب",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          //  authenticationController.signup();

                          authController.register();
                          //     .then((x) {
                          //   if (x == "success") {
                          //     Get.snackbar("تم بنجاح", 'تم إنشاء حساب بنجاح');
                          //     Get.offAllNamed("/VerifyEmail");
                          //   } else {
                          //     Get.snackbar("خطاء", x.toString());
                          //   }
                          // });
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizesConstant.spaceBtwSection,
              ),
              DividerLogin(
                title: "او تسجيل الدخول بواسطة",
              ),
              SizedBox(
                height: SizesConstant.spaceBtwSection,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconSocalMedia(
                    pathImage: ImagesConstant.google,
                    onPressed: () {
                      authController.signInWithGoogle();
                    },
                  ),
                  SizedBox(
                    width: SizesConstant.spaceBtwItem,
                  ),
                  IconSocalMedia(
                    pathImage: ImagesConstant.facebook,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




/*

import 'dart:async';

import 'package:ecommerce_app_client/Core/View/auth/register/verify_email.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/CostumButton.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/DividerLogin.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/IconSocalMedia.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/TextFrmFieldCustom.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/TextFrmFieldPassword.dart';
import 'package:ecommerce_app_client/Core/ViewModel/auth/register/registerVM.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constants/Colors.dart';

class Register extends StatelessWidget {
  Register({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameUserController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
//  final Registervm registerController = Get.put(Registervm());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Customappbar(
          showBackArrow: true,
          onPressed: () => Get.offAllNamed("/Login"),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(SizesConstant.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "مرحباً بك في المتجر",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: SizesConstant.spaceBtwSection,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFrmFieldCustom(
                      controller: nameUserController,
                      labelText: "اسم المستخدم",
                      prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: Image.asset(
                            "${ImagesConstant.user}",
                            color: AppColor.greyIcon,
                            height: SizesConstant.iconSm,
                          )),
                    ),
                    SizedBox(
                      height: SizesConstant.spaceBtwInputField,
                    ),
                    TextFrmFieldCustom(
                      controller: emailController,
                      labelText: "البريد الإلكتروني",
                      prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: Image.asset(
                            "${ImagesConstant.mail_1}",
                            color: AppColor.greyIcon,
                            height: SizesConstant.iconSm,
                          )),
                    ),
                    SizedBox(
                      height: SizesConstant.spaceBtwInputField,
                    ),
                    TextFrmFieldPassword(
                      controller: passwordController,
                      labelText: "كلمة المرور",
                      prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: Image.asset(
                            "${ImagesConstant.padlock}",
                            color: AppColor.greyIcon,
                            height: SizesConstant.iconSm,
                          )),
                      suffixIcon: Transform.scale(
                          scale: 0.5,
                          child: Image.asset(
                            "${ImagesConstant.hide}",
                            color: AppColor.greyIcon,
                            height: SizesConstant.iconSm,
                          )),
                    ),
                    SizedBox(
                      height: SizesConstant.spaceBtwInputField,
                    ),
                    TextFrmFieldPassword(
                      controller: confirmPasswordController,
                      labelText: "تأكيد كلمة المرور",
                      prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: Image.asset(
                            "${ImagesConstant.padlock}",
                            color: AppColor.greyIcon,
                            height: SizesConstant.iconSm,
                          )),
                      suffixIcon: Transform.scale(
                          scale: 0.5,
                          child: Image.asset(
                            "${ImagesConstant.show}",
                            color: AppColor.greyIcon,
                            height: SizesConstant.iconSm,
                          )),
                    ),
                    SizedBox(
                      height: SizesConstant.spaceBtwSection,
                    ),
                    CostumButton(
                        nameButton: "إنشاء حساب",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Registervm registerController = Registervm();
                            registerController.register(
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                                nameUser: nameUserController.text);
                            Get.offAllNamed("/VerifyEmail");
                          }
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: SizesConstant.spaceBtwSection,
              ),
              DividerLogin(
                title: "او تسجيل الدخول بواسطة",
              ),
              SizedBox(
                height: SizesConstant.spaceBtwSection,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconSocalMedia(
                  pathImage: ImagesConstant.google,
                  onPressed: () {},
                ),
                SizedBox(
                  width: SizesConstant.spaceBtwItem,
                ),
                IconSocalMedia(
                  pathImage: ImagesConstant.facebook,
                  onPressed: () {},
                ),
              ]),
            ],
          ),
        )));
  }
}

*/