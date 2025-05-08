import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationLoaderWidget extends StatelessWidget {
  /// Default constructor for the TAnimationLoaderWidget.
  ///
  /// Parameters:
  /// - text: The text to be displayed below the animation.
  /// - animation: The path to the Lottie animation file.
  /// - showAction: Whether to show an action button below the text.
  /// - actionText: The text to be displayed on the action button.
  /// - onActionPressed: Callback function to be executed when the action button is pressed.
 
  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8), // Display Lottie animation
           SizedBox(height: SizesConstant.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
           SizedBox(height: SizesConstant.defaultSpace),
          if (showAction)
            SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: onActionPressed,
                style: OutlinedButton.styleFrom(backgroundColor: AppColor.dark),
                child: Text(
                  actionText!,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(color: AppColor.light),
                ),
              ),
            ),
          const SizedBox(),
        ],
      ),
    );
  }
}