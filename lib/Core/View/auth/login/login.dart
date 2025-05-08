import 'package:ecommerce_app_client/Core/View/auth/register/register.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/CostumButton.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/DividerLogin.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/IconSocalMedia.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/TextFrmFieldPassword.dart';
import 'package:ecommerce_app_client/Core/View/auth/Widget/TextFrmFieldCustom.dart';
import 'package:ecommerce_app_client/Core/View/auth/forgetPassword/ForgetPasswordScreen.dart';
import 'package:ecommerce_app_client/Core/ViewModel/auth/authenticationVM.dart';
import 'package:ecommerce_app_client/Core/server/authController.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:ecommerce_app_client/global/widgets/style/SpaceStyle.dart';
import 'package:ecommerce_app_client/helper/getstorage_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/validation/validation.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Authenticationvm authenticationController = Get.put(Authenticationvm());
  final AuthController authController1 =
      Get.put(AuthController(useFirebase: true));
  GetstorageHelper getstorageHelper = GetstorageHelper.instance;
  @override
  Widget build(BuildContext context) {
    authenticationController.emailLoginController.text =
        getstorageHelper.readFromFile('REMEMBER_ME_EMAIL') ?? "";
    authenticationController.passwordLoginController.text =
        getstorageHelper.readFromFile(
              'REMEMBER_ME_PASSWORD',
            ) ??
            "";
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: Spacestyle.paddingWithAppbarHeight,
          child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    ImagesConstant.logo,
                    height: 100,
                  ),
                  Text(
                    "مرحبا بعودتك",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: SizesConstant.sm,
                  ),
                  Text(
                    "اكتشف خيارات غير محدودة وراحة لا مثيل لها .",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizesConstant.spaceBtwSection),
                  child: Column(
                    children: [
                      TextFrmFieldCustom(
                        validator: (p0) => InputValidator.validateEmail(p0),
                        controller:
                            authenticationController.emailLoginController,
                        labelText: "البريد الالكتروني",
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
                      Obx(
                        () => TextFrmFieldPassword(
                          obscureText:
                              authenticationController.obscureLoginText.value,
                          // validator: (p0) =>   InputValidator.validatePassword(p0),
                          controller:
                              authenticationController.passwordLoginController,
                          labelText: "كلمة السر",
                          prefixIcon: Transform.scale(
                              scale: 0.5,
                              child: Image.asset(
                                "${ImagesConstant.padlock}",
                                color: AppColor.greyIcon,
                                height: SizesConstant.iconSm,
                              )),
                          suffixIcon: IconButton(
                            onPressed: () {
                              authenticationController.obscureLoginText.value =
                                  !authenticationController
                                      .obscureLoginText.value;
                            },
                            icon: SizedBox(
                              height: 25,
                              child: Image.asset(
                                authenticationController.obscureLoginText.value
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
                        height: SizesConstant.spaceBtwInputField / 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: authenticationController
                                      .checkRemember.value,
                                  onChanged: (value) {
                                    authenticationController
                                            .checkRemember.value =
                                        !authenticationController
                                            .checkRemember.value;
                                  },
                                ),
                              ),
                              Text("ذكرني")
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                Get.toNamed("/ForgetPasswordScreen");
                              },
                              child: Text("نسيت كلمة السر"))
                        ],
                      ),
                      SizedBox(
                        height: SizesConstant.spaceBtwSection,
                      ),
                      CostumButton(
                        nameButton: "تسجيل الدخول",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            //  authenticationController.emailAndPasswordSignIn();
                            authController1.signIn();
                            //     .then((x) {
                            //   if (x == "success") {
                            //     Get.snackbar(
                            //         "تم التسجيل", 'تم تسجيل دخولك بنجاح');
                            //     authenticationController
                            //         .passwordLoginController.text = "";
                            //     authenticationController
                            //         .emailLoginController.text = "";
                            //     Get.offAllNamed("/Navigationmenu");
                            //   } else {
                            //     Get.snackbar("خطاء", x.toString());
                            //   }
                            // });
                          }
                        },
                      ),
                      SizedBox(
                        height: SizesConstant.spaceBtwItem,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                              onPressed: () {
                                Get.toNamed("/Createaccount");
                              },
                              child: Text("إنشاء حساب"))),
                    ],
                  ),
                ),
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
                  onPressed: () {
                    authController1.signInWithGoogle();

                    // authenticationController.googleSignIn();
                    // if (authenticationController.message == "success") {
                    //   Get.offAllNamed("/Navigationmenu");
                    // } else if (authenticationController.message == "") {
                    //   print("ahmed");
                    // } else {
                    //   Get.snackbar("error", authenticationController.message);
                    // }
                  },
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
        ),
      )),
    );
  }
}
