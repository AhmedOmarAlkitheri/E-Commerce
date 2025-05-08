

import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/shimmerEffect.dart';
import 'package:flutter/material.dart';

class CategoryShimmer extends StatelessWidget {

    
     

     CategoryShimmer({
        super.key,
        this.itemCount = 6,
    });

    final int itemCount;

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            height: 80,
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: itemCount,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) =>  SizedBox(width:  SizesConstant.spaceBtwItem),
                itemBuilder: (_, __) {
                    return  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            /// Image
                            ShimmerEffect(width: 55, height: 55, radius: 55),
                            SizedBox(height: SizesConstant.spaceBtwItem / 2),
                            /// Text
                            ShimmerEffect(width: 55, height: 8),
                        ],
                    ); // Column
                },
            ), // ListView.separated
        ); // SizedBox
    }
}
