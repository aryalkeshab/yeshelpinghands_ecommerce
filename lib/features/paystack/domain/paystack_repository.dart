import 'package:yeshelpinghand/features/paystack/data/model/request/paystack_initate_params.dart';

import '../../../core/data/data_source/remote/api_result.dart';

abstract class PaystackRepository {
  Future<ApiResponse> initiateTransaction(PaystackInitiateParams params);

  Future<ApiResponse> verifyTransaction(String reference);
}
