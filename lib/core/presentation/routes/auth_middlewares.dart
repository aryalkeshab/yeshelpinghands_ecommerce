import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/auth/presentation/controller/auth_controller.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final isLoggedIn = Get.find<AuthController>().isLoggedIn.value;

    if (isLoggedIn) {
      return null;
    } else {
      return const RouteSettings(name: Routes.login, arguments: true);
    }
  }
}
