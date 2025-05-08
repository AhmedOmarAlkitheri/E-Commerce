
import 'package:ecommerce_app_client/Core/ViewModel/address/addressVM.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/selectNewAddressPopup.dart';
import 'package:ecommerce_app_client/global/widgets/text/sectionHeading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillingAddressSection extends StatelessWidget {
   BillingAddressSection({super.key});



 @override
  Widget build(BuildContext context) {
     final addressController = AddressVM.instance;
        return Obx(
                      () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  SectionHeading(
                      title: 'Shipping Address', buttonTitle: 'Change', onPressed: () => selectNewAddressPopup(context)), // TSectionHeading
                  addressController.selectedAddress.value.id!.isNotEmpty
                      ?  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text( addressController.selectedAddress.value.name!
                                
                                , style: Theme.of(context).textTheme.bodyLarge),
                                 SizedBox(height:  SizesConstant.spaceBtwItem / 2),
                                Row(
                                    children: [
                                        const Icon(Icons.phone, color: Colors.grey, size: 16),
                                         SizedBox(width: SizesConstant.spaceBtwItem ),
                                        Text( addressController.selectedAddress.value.phoneNumber!
                                        , style: Theme.of(context).textTheme.bodyMedium),
                                    ],
                                ), // Row
                                 SizedBox(height: SizesConstant.spaceBtwItem / 2),
                                Row(
                                    children: [
                                        const Icon(Icons.location_history, color: Colors.grey, size: 16),
                                         SizedBox(width: SizesConstant.spaceBtwItem ),
                                        Expanded(child: Text( addressController.selectedAddress.value.toString()
                                        , style: Theme.of(context).textTheme.bodyMedium, softWrap: true)),
                                    ],
                                ), // Row
                            ],
                        
                      ) // Column
                      : Text('Select Address', style: Theme.of(context).textTheme.bodyMedium),
              ],
          ),
        );
    }
}
















//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SectionHeading(
//           title: 'Shipping Address',
//           buttonTitle: 'Change',
//           onPressed: () {},
//         ),
//         Text(
//           'Coding with T',
//           style: Theme.of(context).textTheme.bodyLarge,
//         ),
//          SizedBox(height: SizesConstant.spaceBtwItem / 2),
//         Row(
//           children: [
//             const Icon(Icons.phone, color: Colors.grey, size: 16),
//              SizedBox(width: SizesConstant.spaceBtwItem / 2),
//             Text(
//               '+92-317-8059525',
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           ],
//         ),
//          SizedBox(height: SizesConstant.spaceBtwItem / 2),
//         Row(
//           children: [
//             const Icon(Icons.location_pin, color: Colors.grey, size: 16),
//              SizedBox(width: SizesConstant.spaceBtwItem / 2),
//             Expanded(
//               child: Text(
//                 'South Liana, Maine 87695, USA',
//                 style: Theme.of(context).textTheme.bodyMedium,
//                 softWrap: true,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
