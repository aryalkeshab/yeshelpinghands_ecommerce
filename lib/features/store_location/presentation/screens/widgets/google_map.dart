// import 'dart:async';

// import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapContainer extends StatefulWidget {
//   final String storeName;
//   final double longitude;

//   final double latitude;
//   final String imageUrl;

//   const MapContainer(
//       {super.key,
//       required this.storeName,
//       required this.longitude,
//       required this.latitude,
//       required this.imageUrl});

//   @override
//   State<MapContainer> createState() => MapContainerState();
// }

// class MapContainerState extends State<MapContainer> {
//   final Completer<GoogleMapController> _controller = Completer();

//   // static const CameraPosition storeLocation = CameraPosition(
//   //   target: LatLng(28.220253, 83.986343),
//   //   zoom: 15.0,
//   // );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.storeName)),
//       body: BaseWidget(builder: (context, config, theme) {
//         return Container(
//           padding: EdgeInsets.symmetric(horizontal: config.appEdgePadding()),
//           child: Column(
//             children: [
//               config.verticalSpaceMedium(),
//               Text(
//                 widget.storeName,
//                 textAlign: TextAlign.start,
//                 style: Theme.of(context).textTheme.headline6!.copyWith(),
//               ),
//               config.verticalSpaceMedium(),
//               Text(
//                 'Store Description goes here..',
//                 textAlign: TextAlign.start,
//                 style: Theme.of(context).textTheme.bodyText2!.copyWith(),
//               ),
//               CachedNetworkImage(imageUrl: widget.imageUrl),
//               config.verticalSpaceMedium(),
//               Text(
//                 'In Map View',
//                 textAlign: TextAlign.start,
//                 style: Theme.of(context).textTheme.headline6!.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               config.verticalSpaceMedium(),
//               Expanded(
//                 child: Card(
//                   child: GoogleMap(
//                       mapType: MapType.normal,
//                       initialCameraPosition: CameraPosition(
//                         target: LatLng(widget.latitude, widget.longitude),
//                         zoom: 15.0,
//                       ),
//                       onMapCreated: _controller.complete,
//                       markers: {
//                         Marker(
//                           markerId: MarkerId('${widget.storeName} Store'),
//                           position: LatLng(widget.latitude, widget.longitude),
//                           infoWindow: InfoWindow(
//                             //popup info
//                             title: 'Marker Title First ',
//                             snippet: 'My Custom Subtitle',
//                           ),
//                           onTap: () {},
//                         )
//                       }),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

// //   Future<void> _goToTheLake() async {
// //     final GoogleMapController controller = await _controller.future;
// //     controller.animateCamera(CameraUpdate.newCameraPosition(storeLocation));
// //   }
// }
