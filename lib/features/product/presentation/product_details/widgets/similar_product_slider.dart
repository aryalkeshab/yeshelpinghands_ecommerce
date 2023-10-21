// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../core/presentation/widgets/base_widget.dart';
// import '../../../../../core/presentation/widgets/cached_network_image_builder.dart';
// import '../../../../../core/utils/size_config.dart';
// import '../../../../home/data/models/response/products_model.dart';
// import '../../../../home/presentation/screens/shared/layouts.dart';
// import '../../controller/product_details_controller.dart';
// import '../product_details_screen.dart';
//
// class SimilarProductSilder extends StatelessWidget {
//   const SimilarProductSilder({super.key, required this.config});
//   final SizeConfig config;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SectionHeader(title: "You May Also  Like ", onViewAllProductTap: () {}),
//         SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: List.generate(
//                 Get.put(ProductDetailsController()).similarProduct.length,
//                 (index) {
//               final product =
//                   Get.put(ProductDetailsController()).similarProduct[index];
//               return Row(
//                 children: [
//                   similarProductCard(params: product),
//                   config.horizontalSpaceSmall(),
//                 ],
//               );
//             }),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget similarProductCard(
//       {Function? onCartButtonClick, required ProductModel params}) {
//     return BaseWidget(builder: (context, config, theme) {
//       return Container(
//         width: 190,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black12),
//           borderRadius: BorderRadius.circular(4),
//           color: Colors.white,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             InkWell(
//                 child: CustomCachedNetworkImage(
//                   params.image,
//                   fit: BoxFit.cover,
//                 ),
//                 onTap: () {
//                   Get.to(ProductDetailsScreen.new);
//                 }),
//             config.verticalSpaceSmall(),
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: config.appHorizontalPaddingMedium()),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     child: Text(
//                       '${params.name}',
//                       maxLines: 2,
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyText2!
//                           .copyWith(fontWeight: FontWeight.w600),
//                     ),
//                     width: 180,
//                   ),
//                   config.verticalSpaceMedium(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Rs. ${params.price}',
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyText2!
//                             .copyWith(color: Theme.of(context).primaryColor),
//                       ),
//                       if (params.stock != null && params.stock != 0)
//                         Text('Stocks: ${params.stock}',
//                             style: Theme.of(context).textTheme.caption),
//                     ],
//                   ),
//                   // if (onCartButtonClick != null)
//                   //   PrimaryOutlinedButton(
//                   //     title: 'Add to cart',
//                   //     onPressed: () {},
//                   //   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
