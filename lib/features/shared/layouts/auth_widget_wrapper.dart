import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/presentation/controller/auth_controller.dart';

class AuthWidgetBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, bool isAuthenticated) builder;

  const AuthWidgetBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => builder(context, Get.find<AuthController>().isLoggedIn.value));
  }
}

class AuthWidgetWrapper extends StatelessWidget {
  final Widget child;

  const AuthWidgetWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Get.find<AuthController>().isLoggedIn.value ? child : const SizedBox.shrink());
  }
}
