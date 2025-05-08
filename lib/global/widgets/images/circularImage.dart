import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/shimmerEffect.dart';
import 'package:flutter/material.dart';

class circularImage extends StatelessWidget {
  const circularImage({
    super.key,
    this.padding,
    this.width = 56,
    this.height = 56,
    required this.imageUrl,
    this.fit = BoxFit.fill,
    this.backgroundColor,
    this.isNetworkImage = false,
    this.Imageheight,
    this.Imagewidth,
    this.overlayColor,
    this.border,
  });

  final double? width, height, Imageheight, Imagewidth;
  final String imageUrl;
  final Color? overlayColor;
  final Color? backgroundColor;
  final BoxFit fit;
  final double? padding;
  final BoxBorder? border;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding ?? SizesConstant.sm),
      decoration: BoxDecoration(
        border: border,
        color: backgroundColor ?? (dark ? AppColor.black : AppColor.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
       borderRadius: BorderRadius.circular(100),
        child: Center(
          child:  isNetworkImage ?
          
          CachedNetworkImage(
            color: overlayColor ,
            fit:  fit ,
            progressIndicatorBuilder:  (context, url, progress) => ShimmerEffect(width: 55 ,height: 55,),
            errorWidget: (context, url, error) => Icon(Icons.error) ,
        
        
            imageUrl:  imageUrl
           )
          
          
          : Image(
            fit: fit,
            width: Imagewidth,
            height: Imageheight,
            image: 
                
                 AssetImage(imageUrl) ,
                
               
            color: overlayColor,
          ),
        ),
      ),
    );
  }
}
