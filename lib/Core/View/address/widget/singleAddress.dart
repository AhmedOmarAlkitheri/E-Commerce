import 'package:ecommerce_app_client/Core/Model/addressModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/address/addressVM.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/roundedContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressVM.instance;
    final dark = Helperfunction.isDarkMode(context);

    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: RoundedContainer(
          showBorder: true,
          padding: EdgeInsets.all(SizesConstant.md),
          width: double.infinity,
          backgroundColor: selectedAddress
              ? AppColor.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? AppColor.darkerGrey
                  : AppColor.grey,
          margin: EdgeInsets.only(bottom: SizesConstant.spaceBtwItem),
          child: Stack(
            children: [
              Positioned(
                left: 5,
                top: 0,
                child: Icon(
                  selectedAddress ? Icons.turned_in_rounded : null,
                  color: selectedAddress
                      ? dark
                          ? AppColor.light
                          : AppColor.dark
                      : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: SizesConstant.sm / 2),
                  Text(
                    address.formattedPhoneNo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: SizesConstant.sm / 2),
                  Text(address.toString(), softWrap: true),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}









































//     super.key,
//     required this.selectedAddress,
//   });

//   final bool selectedAddress;

//   @override
//   Widget build(BuildContext context) {
//     final dark = Helperfunction.isDarkMode(context);
//     return RoundedContainer(
//       padding: EdgeInsets.all(SizesConstant.md),
//       width: double.infinity,
//       showBorder: true,
//       backgroundColor: selectedAddress
//           ? AppColor.primary.withOpacity(0.5)
//           : Colors.transparent,
//       borderColor: selectedAddress
//           ? Colors.transparent
//           : dark
//               ? AppColor.darkerGrey
//               : AppColor.grey,
//       margin: EdgeInsets.only(bottom: SizesConstant.spaceBtwItem),
//       child: Stack(
//         children: [
//           Positioned(
//             left: 5,
//             top: 0,
//             child: Icon(
//               selectedAddress ? Icons.turned_in_rounded : null,
//               color: selectedAddress
//                   ? dark
//                       ? AppColor.light
//                       : AppColor.dark
//                   : null,
//             ), // Icon
//           ), // Positioned
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: SizesConstant.sm / 2),
//               Text(
//                 'أحمد الكثيري',
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: Theme.of(context).textTheme.titleLarge,
//               ), // Text
//               SizedBox(height: SizesConstant.sm / 2),
//               const Text('(+967) 730280622',
//                   maxLines: 1, overflow: TextOverflow.ellipsis),
//               SizedBox(height: SizesConstant.sm / 2),
//               const Text('82556 باخزمة, الحوطة, حضرموت, 87665, اليمن',
//                   softWrap: true),
//               SizedBox(height: SizesConstant.sm / 2),
//             ], // Column
//           ),
//         ], // Stack
//       ),
//     ); // TRoundedContainer
//   }
// }
