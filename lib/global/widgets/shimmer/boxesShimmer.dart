import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/shimmerEffect.dart';
import 'package:flutter/material.dart';
class BoxesShimmer extends StatelessWidget {
    const BoxesShimmer({super.key});

    @override
    Widget build(BuildContext context) {
        return  Column(
            children: [
                Row(
                    children: [
                        Expanded(child: ShimmerEffect(width: 150, height: 110)),
                        SizedBox(width:  SizesConstant.spaceBtwItem),
                        Expanded(child: ShimmerEffect(width: 150, height: 110)),
                        SizedBox(width:  SizesConstant.spaceBtwItem),
                        Expanded(child: ShimmerEffect(width: 150, height: 110)),
                    ],
                ), // Row
            ],
        ); // Column
    }
}