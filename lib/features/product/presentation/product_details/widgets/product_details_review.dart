// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
//
// import '../../../../../core/presentation/resources/colors.dart';
// import '../../../../../core/presentation/widgets/cached_network_image_builder.dart';
// import '../../../../../core/utils/size_config.dart';
// import '../../controller/product_details_controller.dart';
//
// class ProductReviewSection extends StatelessWidget {
//   final BuildContext context;
//   final ThemeData theme;
//   final SizeConfig config;
//
//   const ProductReviewSection({
//     required this.context,
//     required this.config,
//     required this.theme,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.all(10),
//           child: Text(
//             'Rating & Reviews',
//             style: theme.textTheme.bodyText1
//                 ?.copyWith(color: dividerColor, fontWeight: FontWeight.w900),
//           ),
//         ),
//         GetBuilder<ProductDetailsController>(
//             init: ProductDetailsController(),
//             builder: (context) {
//               final result = Get.find<ProductDetailsController>().reviewHistory;
//               var len = result.length;
//               return Container(
//                 height: config.appHeight(len * 24),
//                 margin: EdgeInsets.only(bottom: 20),
//                 child: ListView.builder(
//                     itemCount: result.length,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (BuildContext context, int index) {
//                       var reviewinfo = result[index];
//                       return Card(
//                         elevation: null,
//                         color: cardbodycolor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 20,
//                                   backgroundColor: Colors.white,
//                                   child: ClipOval(
//                                     child:
//                                         //     Icon(
//                                         //   Icons.person,
//                                         //   color: Colors.black,
//                                         //   size: 18,
//                                         // )
//                                         CustomCachedNetworkImage(
//                                       reviewinfo.user.profileImage,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20),
//                                     child: Text(
//                                       //'Helene Moore',
//                                       "${reviewinfo.user.firstname} ${reviewinfo.user.lastname}",
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w600),
//                                     )),
//                                 Text(
//                                   //'3 Month Ago',
//                                   reviewinfo.createdOn,
//                                   style: const TextStyle(color: Colors.black54),
//                                 )
//                               ],
//                             ),
//                             const Divider(),
//                             // Row(
//                             //     mainAxisAlignment: MainAxisAlignment.start,
//                             //     crossAxisAlignment: CrossAxisAlignment.center,
//                             //     children: List.generate(
//                             //         5,
//                             //         (index) => IconButton(
//                             //               onPressed: () {},
//                             //               icon: Icon(
//                             //                 Icons.star,
//                             //                 size: 24,
//                             //               ),
//                             //               color: Color.fromRGBO(254, 207, 69, 1),
//                             //
//                             //          ))),
//                             Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   RatingBar.builder(
//                                     initialRating: double.parse(
//                                         reviewinfo.rating.toString()),
//                                     minRating: 1,
//                                     direction: Axis.horizontal,
//                                     allowHalfRating: true,
//                                     itemCount: 5,
//                                     itemPadding: const EdgeInsets.symmetric(
//                                         horizontal: 4.0),
//                                     itemSize: 24,
//                                     glow: false,
//                                     ignoreGestures: true,
//                                     itemBuilder: (context, _) => const Icon(
//                                       Icons.star,
//                                       color: Colors.amber,
//                                     ),
//                                     onRatingUpdate: (rating) {
//                                       print(rating);
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Text(reviewinfo.message),
//                           ]),
//                         ),
//                       );
//                     }),
//               );
//             }),
//         reviewFromCard(),
//       ],
//     );
//   }
//
//   // widget for product details on card
//   Widget reviewFromCard() {
//     return Container(
//         width: double.infinity,
//         //height: 200,
//
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         child: Card(
//           elevation: null,
//           color: Colors.grey,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//                 //mainAxisAlignment: MainAxisAlignment.,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 8),
//                     child: Text(
//                       'Rate this Product.',
//                       style: theme.textTheme.bodyLarge?.copyWith(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   RatingBar.builder(
//                     initialRating: 3,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: false,
//                     itemCount: 5,
//                     itemPadding: const EdgeInsets.symmetric(horizontal: 6.0),
//                     itemSize: 30,
//                     itemBuilder: (context, _) => const Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (rating) {
//                       print(rating);
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     child: Text(
//                       'Share Your Opinion about this Product.',
//                       style: theme.textTheme.bodyMedium
//                           ?.copyWith(fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   Form(
//                     child: Column(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.rectangle,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(width: 1, color: Colors.grey),
//                           ),
//                           child: TextFormField(
//                             // textAlign: TextAlign.center,
//                             minLines: 2,
//                             maxLines: null,
//                             keyboardType: TextInputType.multiline,
//                             autocorrect: false,
//                             autofocus: false,
//                             style: const TextStyle(color: Colors.black),
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             decoration: const InputDecoration(
//                               border: InputBorder.none,
//                               labelText: "Enter your Review",
//                               // hintStyle: TextStyle(
//                               //   color: Colors.black,
//                               //   fontWeight: FontWeight.w500,
//                               // ),
//                               alignLabelWithHint: true,
//                               labelStyle: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w200,
//                               ),
//                               // focusedBorder: OutlineInputBorder(
//                               //     borderRadius: BorderRadius.all(
//                               //         Radius.circular(10.0)),
//                               //     borderSide:
//                               //         BorderSide(color: Colors.black54)
//                               //         )
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 10,
//                             horizontal: 4,
//                           ),
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             child: const Text('Send Review'),
//                             style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ]),
//           ),
//         ));
//   }
// }
