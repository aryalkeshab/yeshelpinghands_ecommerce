import 'package:yeshelpinghand/core/presentation/resources/ui_assets.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/cart_request_params.dart';
import 'package:yeshelpinghand/features/cart/data/model/response/cart_details.dart';
import 'package:yeshelpinghand/features/cart/presentation/controller/cart_controller.dart';
import 'package:yeshelpinghand/features/cart/presentation/screen/cart_screen.dart';
import 'package:yeshelpinghand/features/categories/presentation/screen/category_screen.dart';
import 'package:yeshelpinghand/features/home/presentation/screens/home_screen.dart';
import 'package:yeshelpinghand/features/profile/presentation/screen/profile_screen.dart';
import 'package:yeshelpinghand/features/shared/layouts/auth_interceptor_screen.dart';
import 'package:yeshelpinghand/features/shared/layouts/auth_widget_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/features/shared/layouts/confirm_dialog_view.dart';

import '../../cart/presentation/screen/empty_cart_screen.dart';
import '../../auth/presentation/screen/login_screen.dart';
import '../controllers/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => ConfirmDialogView(
              primaryText: "Are you sure you want to exit the app?",
              onApproveButtonPressed: () {
                Get.back(result: true);
              },
              onCancelButtonPressed: () {
                Get.back(result: false);
              },
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return GetBuilder<DashboardController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          if (controller.tabIndex > 0) {
            controller.changeTabIndex(0);
            return false;
          } else {
            return showExitPopup();
          }
        },
        child: Scaffold(
          body: IndexedStack(
            index: Get.find<DashboardController>().tabIndex,
            children: [
              const HomeScreen(),
              const CategoryScreen(),
              AuthWidgetBuilder(builder: (context, isAuthenticated) {
                return isAuthenticated ? CartScreen() : const EmptyCartScreen();
              }),
              AuthWidgetBuilder(builder: (context, isAuthenticated) {
                return isAuthenticated
                    ? const ProfileScreen()
                    : const LoginScreen(
                        showLeading: false,
                      );
              }),
            ],
          ),
          // body: Navigator(
          //   key: Get.nestedKey(1),
          //   initialRoute: Routes.home,
          //   onGenerateRoute: controller.onGenerateRoute,
          // ),
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 22,
            unselectedItemColor: Colors.black,
            selectedItemColor: const Color(0xFFff8201),
            onTap: Get.find<DashboardController>().changeTabIndex,
            currentIndex: Get.find<DashboardController>().tabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            // selectedLabelStyle: TextStyle(color: Colors.black),
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: Icons.home,
                label: 'Home',
              ),
              _bottomNavigationBarItemWithExternalSvg(
                isActive: Get.find<DashboardController>().tabIndex == 1,
                icon: UIAssets.getSvg("categories.svg"),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: GetBuilder<CartController>(
                  builder: ((controller) {
                    final result = controller.cartDetailResponse;
                    final CartResponse? cartResponse = result.data;
                    final cartDetail = cartResponse?.carts;
                    return AuthWidgetBuilder(
                        builder: ((context, isAuthenticated) {
                      return !isAuthenticated
                          ? Icon(CupertinoIcons.cart, size: 22)
                          : cartDetail?.length == 0
                              ? Icon(CupertinoIcons.cart, size: 22)
                              : Stack(
                                  children: [
                                    const Icon(CupertinoIcons.cart, size: 22),
                                    Positioned(
                                      left: 12,
                                      bottom: 10,
                                      child: cartDetail?.length != null
                                          ? Container(
                                              alignment: Alignment.center,
                                              // height: 18,
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red,
                                                // borderRadius:
                                                //     BorderRadius.circular(9),
                                              ),
                                              constraints: const BoxConstraints(
                                                minWidth: 10,
                                                minHeight: 10,
                                              ),
                                              child: Text(
                                                '${cartDetail?.length}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 7,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    ),
                                  ],
                                );
                    }));
                  }),
                ),
                label: 'Cart',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.person,
                label: 'Account',
              ),
            ],
          ),
        ),
      );
    });
  }

  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 25),
      label: label,
    );
  }

  _bottomNavigationBarItemWithExternalSvg(
      {bool isActive = false, required String icon, required String label}) {
    return BottomNavigationBarItem(
      backgroundColor: const Color(0xFFff8201),
      icon: SvgPicture.asset(
        icon,
        color: isActive ? const Color(0xFFff8201) : Colors.black,
        width: 17,
      ),
      label: label,
    );
  }
}
