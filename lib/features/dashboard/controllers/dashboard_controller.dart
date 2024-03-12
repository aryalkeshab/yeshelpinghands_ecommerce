import 'package:get/get.dart';

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
