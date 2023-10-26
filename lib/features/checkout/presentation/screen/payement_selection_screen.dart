import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/confirm_order_params.dart';
import 'package:yeshelpinghand/features/checkout/data/model/response/payment_method.dart';
import 'package:yeshelpinghand/features/checkout/presentation/controller/payment_methods_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yeshelpinghand/features/checkout/presentation/screen/widgets/checkout_stepper.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';

import '../../../../core/presentation/resources/ui_assets.dart';
import '../../../../core/presentation/widgets/base_widget.dart';
import '../../../../core/presentation/widgets/focus_node_disabler.dart';
import 'utils/payement_type_enum.dart';

class PaymentSelectionScreen extends StatelessWidget {
  final ConfirmOrderParams confirmOrderParams;

  PaymentSelectionScreen({Key? key, required this.confirmOrderParams})
      : super(key: key);
  PaymentMethod? paymentMethod;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return CheckoutStepper(
        onProceed: () {
          Get.find<PaymentMethodsController>()
              .setPaymentMethod(context, confirmOrderParams);
        },
        currentStep: 2,
        child: _PaymentSelectionView(
          onPaymentSelect: (paymentMethod) {
            // confirmOrderParams.paymentMethod = paymentMethod;
          },
        ),
      );
    });
  }
}

class _PaymentSelectionView extends StatelessWidget {
  final Function(PaymentMethod) onPaymentSelect;

  const _PaymentSelectionView({
    Key? key,
    required this.onPaymentSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<PaymentMethod> paymentMethods = [
      PaymentMethod(
        label: 'Cash on delivery',
      )
    ];
    return HookBaseWidget(builder: (context, config, theme) {
      final selectedPaymentType = useState(0);
      return Column(
        children: [
          Text(
            'Select Payment Type',
            style: theme.textTheme.bodyText1
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          config.verticalSpaceSmall(),
          Column(
            children: List.generate(paymentMethods.length, (index) {
              final paymentMethod = paymentMethods[index];
              return _PaymentCard(
                title: "${paymentMethod.label}",
                onSelect: () {
                  selectedPaymentType.value = index;
                  onPaymentSelect(paymentMethods[selectedPaymentType.value]);
                },
                isSelected: selectedPaymentType.value == index,
              );
            }),
          ),
        ],
      );
    });
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({
    Key? key,
    required this.isSelected,
    required this.title,
    this.icon,
    required this.onSelect,
  }) : super(key: key);

  final String title;
  final String? icon;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return InkWell(
        onTap: onSelect,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: isSelected
              ? BoxDecoration(border: Border.all(color: theme.primaryColor))
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null)
                    Image.asset(
                      UIAssets.getImage("$icon"),
                      width: 50,
                      height: 50,
                    ),
                  config.horizontalSpaceMedium(),
                  Text("$title"),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
              Icon(isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: theme.primaryColor),
            ],
          ),
        ),
      );
    });
  }
}
