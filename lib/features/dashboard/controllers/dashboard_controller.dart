import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/features/cart/di/cart_binding.dart';
import 'package:yeshelpinghand/features/cart/presentation/screen/cart_screen.dart';
import 'package:yeshelpinghand/features/categories/di/category_bindings.dart';
import 'package:yeshelpinghand/features/home/di/home_bindings.dart';
import 'package:yeshelpinghand/features/home/presentation/screens/home_screen.dart';
import 'package:yeshelpinghand/features/product/di/product_binding.dart';
import 'package:yeshelpinghand/features/profile/di/profile_bindings.dart';
import 'package:yeshelpinghand/features/profile/presentation/screen/profile_screen.dart';
import 'package:yeshelpinghand/features/shared/layouts/auth_interceptor_screen.dart';
import 'package:yeshelpinghand/features/shared/layouts/auth_widget_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../categories/presentation/screen/category_screen.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;

  // void changeTabIndex(int index) {
  //   tabIndex = index;
  //   Get.toNamed(pages[index], id: 1);
  //   update();
  // }

  void changeTabIndex(int index) {
    tabIndex = index;

    update();
  }

  // final pages = <String>[
  //   Routes.home,
  //   Routes.category,
  //   Routes.cart,
  //   Routes.profile
  // ];
  //
  // Route? onGenerateRoute(RouteSettings settings) {
  //   if (settings.name == Routes.home)
  //     return GetPageRoute(
  //       settings: settings,
  //       page: () => HomeScreen(),
  //       bindings: [HomeBindings(), ProductBindings()],
  //     );
  //
  //   if (settings.name == Routes.category)
  //     return GetPageRoute(
  //       settings: settings,
  //       page: () => CategoryScreen(),
  //       binding: CategoryBindings(),
  //     );
  //
  //   if (settings.name == Routes.cart)
  //     return GetPageRoute(
  //       settings: settings,
  //       page: () => AuthWidgetBuilder(
  //         builder: (context, isAuthenticated) {
  //           return isAuthenticated ? CartScreen() : AuthInterceptorScreen();
  //         },
  //       ),
  //       binding: CartBinding(),
  //       // binding: SettingsBinding(),
  //     );
  //   if (settings.name == Routes.profile)
  //     return GetPageRoute(
  //       settings: settings,
  //       page: () => AuthWidgetBuilder(
  //         builder: (context, isAuthenticated) {
  //           return isAuthenticated ? ProfileScreen() : AuthInterceptorScreen();
  //         },
  //       ),
  //       binding: ProfileBinding(),
  //     );
  //
  //   return null;
  // }
}
