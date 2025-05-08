import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = AppColor.white,
    this.backgroundColor,
    this.onTap,
  });

  final String image, title;
  final Color? textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: SizesConstant.spaceBtwItem),
        child: Column(
          children: [
            // Circular Icon
            Container(
              width: 56,
              height: 56,
              padding: EdgeInsets.all(SizesConstant.sm),
              decoration: BoxDecoration(
                color:
                    backgroundColor ?? (dark ? AppColor.dark : AppColor.light),
                borderRadius: BorderRadius.circular(100),
              ), // BoxDecoration
              child: Center(
                child: Image(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                  color: dark ? AppColor.light : AppColor.dark,
                ),
              ),
            ),

            SizedBox(height: SizesConstant.spaceBtwItem / 2),

            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
