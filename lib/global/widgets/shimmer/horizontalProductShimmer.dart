import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/shimmerEffect.dart';
import 'package:flutter/material.dart';

class HorizontalProductShimmer extends StatelessWidget {
    const HorizontalProductShimmer({
        super.key,
        this.itemCount = 4,
    });

    final int itemCount;

    @override
    Widget build(BuildContext context) {
        return Container(
            margin:  EdgeInsets.only(bottom: SizesConstant.spaceBtwSection),
            height: 120,
            child: ListView.separated(
                itemCount: itemCount,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) =>  SizedBox(width: SizesConstant.spaceBtwItem),
                itemBuilder: (_, index) =>  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        /// Image
                        ShimmerEffect(width: 120, height: 120),
                        SizedBox(width:  SizesConstant.spaceBtwItem),


                    // Text
Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
        SizedBox(height:  SizesConstant.spaceBtwItem / 2),
        ShimmerEffect(width: 160, height: 15),
        SizedBox(height:  SizesConstant.spaceBtwItem / 2),
        ShimmerEffect(width: 110, height: 15),
        SizedBox(height:  SizesConstant.spaceBtwItem / 2),
        ShimmerEffect(width: 80, height: 15),
        Spacer(),
    ],
),
                    ]
                )
            )
            );
    }
}