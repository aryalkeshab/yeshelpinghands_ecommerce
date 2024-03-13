import 'package:get/get.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/payment_status_update_params.dart';
import 'package:yeshelpinghand/features/checkout/domain/repository/checkout_repository.dart';

class CheckoutController extends GetxController {
  updatePaymentStatus(PaymentStatusUpdateParams params) async {
    final result = await Get.find<CheckoutRepository>().updatePaymentStatus(params);
  }
}
