import 'package:yeshelpinghand/main_common.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await mainCommon();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const Application(), // Wrap your app
    ),
  );
}
