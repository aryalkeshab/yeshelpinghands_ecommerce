import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/presentation/resources/colors.dart';
import 'package:yeshelpinghand/core/presentation/widgets/focus_node_disabler.dart';
import 'package:yeshelpinghand/core/presentation/widgets/toast.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/cart_request_params.dart';
import 'package:yeshelpinghand/features/cart/presentation/controller/cart_controller.dart';
import 'package:yeshelpinghand/features/product/data/model/response/product_details.dart';
import 'package:yeshelpinghand/features/product/presentation/product_details/widgets/product_details_view.dart';
import '../../../../../core/presentation/widgets/base_widget.dart';
import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../../core/presentation/routes/app_pages.dart';
import '../../../../core/presentation/widgets/buttons.dart';
import '../../../shared/layouts/auth_widget_wrapper.dart';
import '../../../shared/layouts/error_view.dart';
import '../controller/product_details_controller.dart';
import 'widgets/product_details_loading.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productSku;

  ProductDetailsScreen({required this.productSku});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //backgroundLight,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: GetBuilder<ProductDetailsController>(builder: (controller) {
        final result = controller.productDetailsResponse;
        if (result.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductDetailsBottomSheet(productDetails: result.data),
          );
        } else {
          return const SizedBox();
        }
      }),
      body: FocusNodeDisabler(
        child: BaseWidget(builder: (context, config, theme) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: config.appVerticalPaddingSmall(),
                horizontal: config.appHorizontalPaddingSmall()),
            child: GetBuilder<ProductDetailsController>(
                init: ProductDetailsController(widget.productSku),
                builder: (controller) {
                  final result = controller.productDetailsResponse;
                  if (result.hasData) {
                    return ProductDetailsView(
                      productDetails: result.data,
                    );
                  } else if (result.hasError) {
                    return Center(
                      child: ErrorView(title: "${NetworkException.getErrorMessage(result.error)}"),
                    );
                  } else {
                    return const ProductDetailsLoading();
                  }
                }),
          );
        }),
      ),
    );
  }
}

class ProductDetailsBottomSheet extends StatelessWidget {
  final ProductDetails productDetails;

  const ProductDetailsBottomSheet({Key? key, required this.productDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return AuthWidgetBuilder(builder: (context, isAuthenticated) {
        return SizedBox(
            height: 50,
            child: PrimaryButton(
              color: productDetails.inStock! ? theme.primaryColor : lightGreen,
              label: productDetails.inStock!
                  ? "ADD TO CART"
                  : productDetails.isCart == true
                      ? "Already in cart"
                      : "OUT OF STOCK",
              labelWeight: FontWeight.w600,
              onPressed: isAuthenticated
                  ? () {
                      if (productDetails.inStock!) {
                        if (productDetails.isCart == false) {
                          Get.find<CartController>()
                              .addToCart(context, CartParams(slug: productDetails.slug, qty: 1));
                        } else {
                          showFailureToast("Product is already in cart");
                        }
                      } else {}
                    }
                  : () {
                      Get.toNamed(Routes.login, arguments: true);
                    },
            ));
      });
    });
  }
}
