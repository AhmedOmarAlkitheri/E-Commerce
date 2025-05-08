
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/Layout/gridLayout.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/shimmerEffect.dart';
import 'package:flutter/material.dart';

class VerticalProductShimmer extends StatelessWidget {
    const VerticalProductShimmer({
        super.key,
        this.itemCount = 4,
    });

    final int itemCount;

    @override
    Widget build(BuildContext context) {
        return GridLayout(
            itemCount: itemCount,
            itemBuilder: (_, __) =>  SizedBox(
                width: 180,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        /// Image
                        ShimmerEffect(width: 180, height: 180),
                        SizedBox(height: SizesConstant.spaceBtwItem),
                        /// Text
                        ShimmerEffect(width: 160, height: 15),
                        SizedBox(height:SizesConstant.spaceBtwItem / 2),
                        ShimmerEffect(width: 110, height: 15),
                    ],
                ), // Column
            ), // SizedBox
        ); // TGridLayout
    }
}