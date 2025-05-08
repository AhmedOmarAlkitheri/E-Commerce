import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:flutter/material.dart';

class RatingAndShare extends StatelessWidget {
  const RatingAndShare({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          const Icon(Icons.star_sharp, color: Colors.amber, size: 24),
          SizedBox(width: SizesConstant.spaceBtwItem / 2),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '5.0 ', style: Theme.of(context).textTheme.bodyLarge),
                const TextSpan(text: '(199)'),
              ],
            ), // TextSpan
          ), // Text.rich
        ],
      ), // Row

      /// Share Button
      IconButton(
          onPressed: () {},
          icon: Icon(Icons.share, size: SizesConstant.iconMd)),
    ]);
  }
}
