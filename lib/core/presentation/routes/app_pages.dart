import 'package:yeshelpinghand/core/presentation/routes/auth_middlewares.dart';
import 'package:yeshelpinghand/features/address/di/address_binding.dart';
import 'package:yeshelpinghand/features/address/presentation/add_address_screen.dart';
import 'package:yeshelpinghand/features/address/presentation/address_list_screen.dart';
import 'package:yeshelpinghand/features/auth/di/login_bindings.dart';
import 'package:yeshelpinghand/features/auth/di/password_reset_bindings.dart';
import 'package:yeshelpinghand/features/auth/di/password_update_bindings.dart';
import 'package:yeshelpinghand/features/auth/di/register_bindings.dart';
import 'package:yeshelpinghand/features/auth/presentation/screen/login_screen.dart';
import 'package:yeshelpinghand/features/auth/presentation/screen/password_update_screen.dart';
import 'package:yeshelpinghand/features/auth/presentation/screen/register_screen.dart';
import 'package:yeshelpinghand/features/cart/di/cart_binding.dart';
import 'package:yeshelpinghand/features/checkout/di/checkout_bindings.dart';
import 'package:yeshelpinghand/features/checkout/presentation/screen/checkout_summary_screen.dart';
import 'package:yeshelpinghand/features/checkout/presentation/screen/shipping_address_screen.dart';
import 'package:yeshelpinghand/features/crm/di/contact_us_bindings.dart';
import 'package:yeshelpinghand/features/crm/di/crm_bindings.dart';
import 'package:yeshelpinghand/features/crm/presentation/screen/about_us.dart';
import 'package:yeshelpinghand/features/crm/presentation/screen/contact_us.dart';
import 'package:yeshelpinghand/features/crm/presentation/screen/help_faqs.dart';
import 'package:yeshelpinghand/features/crm/presentation/screen/privacy_policy.dart';
import 'package:yeshelpinghand/features/crm/presentation/screen/terms_and_condition.dart';
import 'package:yeshelpinghand/features/dashboard/di/dashboard_bindings.dart';
import 'package:yeshelpinghand/features/dashboard/presentation/dashboard_screen.dart';
import 'package:yeshelpinghand/features/home/di/home_bindings.dart';
import 'package:yeshelpinghand/features/on_boarding/presentation/intro/language_selection_screen.dart';
import 'package:yeshelpinghand/features/order/di/order_binding.dart';
import 'package:yeshelpinghand/features/order/presentation/order_history_details_screen.dart';
import 'package:yeshelpinghand/features/order/presentation/order_history_screen.dart';
import 'package:yeshelpinghand/features/product/di/product_binding.dart';
import 'package:yeshelpinghand/features/product/presentation/product_listing/product_listing_screen.dart';
import 'package:yeshelpinghand/features/profile/di/profile_bindings.dart';
import 'package:yeshelpinghand/features/profile/presentation/screen/account_details_screen.dart';
import 'package:yeshelpinghand/features/profile/presentation/screen/profile_screen.dart';
import 'package:yeshelpinghand/features/reviews/di/review_bindings.dart';
import 'package:yeshelpinghand/features/search/presentation/screen/search_screen.dart';
import 'package:yeshelpinghand/features/store_location/presentation/screens/store_location.dart';
import 'package:yeshelpinghand/features/wishlist/di/wishlist_binding.dart';
import 'package:yeshelpinghand/features/wishlist/presentation/screen/wishlist_screen.dart';
import 'package:get/get.dart';
import '../../../features/auth/di/auth_bindings.dart';
import '../../../features/auth/presentation/screen/password_reset_screen.dart';
import '../../../features/categories/di/category_bindings.dart';
import '../../../features/checkout/presentation/screen/payement_selection_screen.dart';
import '../../../features/on_boarding/presentation/intro/intro_screen.dart';
import '../../../features/on_boarding/presentation/splash/splash_screen.dart';
import '../../../features/product/presentation/product_details/product_details_screen.dart';
import '../../di/core_bindings.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.dashboard;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: SplashScreen.new,
      bindings: [
        DashboardBindings(),
        CoreBindings(),
        AuthBindings(),
        WishListBinding(),
        HomeBindings(),
        CartBinding(),
        CategoryBindings(),
        ProfileBinding(),
        ProductBindings(),
      ],
    ),
    GetPage(
      name: _Paths.onBoarding,
      page: IntroScreen.new,
    ),
    GetPage(
      name: _Paths.chooseLanguage,
      page: LanguageSelectionScreen.new,
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginScreen(
        showLeading: Get.arguments,
      ),
      bindings: [AuthBindings(), LoginBindings()],
    ),
    GetPage(
      name: _Paths.register,
      page: () => RegisterScreen(
        customerFormParams: Get.arguments,
      ),
      binding: RegisterBindings(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: DashboardScreen.new,
      bindings: [
        DashboardBindings(),
        CoreBindings(),
        AuthBindings(),
        WishListBinding(),
        HomeBindings(),
        CartBinding(),
        CategoryBindings(),
        ProfileBinding(),
        ProductBindings(),
        LoginBindings()
      ],
    ),
    GetPage(
        name: _Paths.shipping,
        page: () => ShippingAddressScreen(confirmOrderParams: Get.arguments),
        bindings: [
          AddressBinding(),
          CheckoutBindings(),
        ]),
    GetPage(
      name: _Paths.checkoutSummary,
      page: () => CheckoutSummaryScreen(confirmOrderParams: Get.arguments),
      bindings: [
        CheckoutBindings(),
      ],
    ),
    GetPage(
      name: _Paths.paymentScreen,
      page: () => PaymentSelectionScreen(confirmOrderParams: Get.arguments),
    ),
    GetPage(
      name: _Paths.search,
      page: SearchScreen.new,
    ),
    GetPage(
        name: _Paths.wishList,
        page: WishListScreen.new,
        binding: WishListBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
      name: _Paths.productListingScreen,
      page: () => ProductListingScreen(
        filterQueryParams: Get.arguments,
      ),
      bindings: [
        ProductBindings(),
        CoreBindings(),
      ],
    ),
    GetPage(
        name: _Paths.productDetails,
        page: () => ProductDetailsScreen(
              productSku: Get.arguments,
            ),
        bindings: [
          CartBinding(),
          ReviewBindings(),
        ]),
    GetPage(name: _Paths.orderHistory, page: OrderHistoryScreen.new, bindings: [OrderBinding()]),
    GetPage(
      name: _Paths.termsAndCondition,
      page: TermsAndConditionScreen.new,
      binding: CRMBindings(),
    ),
    GetPage(
      name: _Paths.privacyPolicy,
      page: PrivacyPolicyScreen.new,
      binding: CRMBindings(),
    ),
    GetPage(
      name: _Paths.contactUs,
      page: ContactUsScreen.new,
      bindings: [
        CRMBindings(),
        ContactUsBindings(),
      ],
    ),
    GetPage(
      name: _Paths.aboutUs,
      page: AboutUsScreen.new,
      binding: CRMBindings(),
    ),
    GetPage(
      name: _Paths.orderHistoryDetail,
      page: () => OrderHistoryDetailsScreen(orderNo: Get.arguments),
    ),
    GetPage(
      name: _Paths.storeLocator,
      page: () => const StoreLocationScreen(),
    ),
    GetPage(
        name: _Paths.passwordUpdate,
        page: () => const PasswordUpdateScreen(),
        bindings: [PasswordUpdateBindings()]),
    GetPage(
        name: _Paths.addAddress,
        page: () => AddAddressScreen(
              addressFormParams: Get.arguments,
            ),
        middlewares: [
          AuthGuard(),
        ]),
    GetPage(
        name: _Paths.addressList,
        page: () => AddressListScreen(
              addressBookType: Get.arguments,
            ),
        binding: AddressBinding(),
        middlewares: [
          AuthGuard(),
        ]),
    GetPage(
      name: _Paths.passwordReset,
      page: () => PasswordResetScreen(),
      binding: PasswordResetBindings(),
    ),
    GetPage(
        name: _Paths.accountDetails,
        page: () => const AccountDetailScreen(),
        middlewares: [AuthGuard()]),
    GetPage(
      name: _Paths.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.helpFaqs,
      page: HelpFaqsScreen.new,
      binding: CRMBindings(),
    ),
  ];
}
