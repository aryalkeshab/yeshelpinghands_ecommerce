import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/features/paystack/presentation/controller/paystack_controller.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class PaystackScreenParams {
  String? paymentUrl;
  String? referenceNo;

  PaystackScreenParams({this.paymentUrl, this.referenceNo});
}

// class PaystackScreen extends StatefulWidget {
//   final PaystackScreenParams paystackScreenParams;

//   const PaystackScreen({Key? key, required this.paystackScreenParams})
//       : super(key: key);

//   @override
//   State<PaystackScreen> createState() => _PaystackScreenState();
// }

// class _PaystackScreenState extends State<PaystackScreen> {
//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) {
//       WebView.platform = SurfaceAndroidWebView();
//     }
//   }

//   late WebViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//               iconSize: 30,
//               onPressed: () {
//                 Get.find<PaystackController>().verifyTransaction(
//                     context, widget.paystackScreenParams.referenceNo);
//               },
//               icon: const Icon(Icons.close))
//         ],
//       ),
//       body: SafeArea(
//         child: WebView(
//           javascriptMode: JavascriptMode.unrestricted,
//           initialUrl: widget.paystackScreenParams.paymentUrl,
//           onWebViewCreated: (controller) {
//             _controller = controller;
//             controller.clearCache();
//             CookieManager().clearCookies();
//           },
//           navigationDelegate: (navReq) {
//             if (navReq.url
//                 .startsWith("https://yeshelpinghand.store/checkout/cart/")) {
//               Get.find<PaystackController>().verifyTransaction(
//                   context, widget.paystackScreenParams.referenceNo);
//               return NavigationDecision.prevent;
//             } else {
//               return NavigationDecision.navigate;
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
