
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/shimmerEffect.dart';
import 'package:flutter/material.dart';

class ListTileShimmer extends StatelessWidget {
    const ListTileShimmer({super.key});

    @override
    Widget build(BuildContext context) {
        return  Column(
            children: [
                Row(
                    children: [
                        ShimmerEffect(width: 50, height: 50, radius: 50),
                        SizedBox(width:  SizesConstant.spaceBtwItem),
                        Column(
                            children: [
                                ShimmerEffect(width: 100, height: 15),
                                SizedBox(height: SizesConstant.spaceBtwItem / 2),
                                ShimmerEffect(width: 80, height: 12),
                            ],
                        ), // Column
                    ],
                ), // Row
            ],
        ); // Column
    }
}