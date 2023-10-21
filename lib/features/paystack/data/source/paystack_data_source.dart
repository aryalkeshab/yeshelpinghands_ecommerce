import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

import '../model/request/paystack_initate_params.dart';

abstract class PaystackDataSource {
  Future<dynamic> initiateTransaction(PaystackInitiateParams params);

  Future<dynamic> verifyTransaction(String reference);
}

class PaystackDataSourceImpl extends PaystackDataSource {
  final Dio dio;

  PaystackDataSourceImpl({required this.dio});

  @override
  Future initiateTransaction(PaystackInitiateParams params) async {
    final secret = dotenv.env['PAYSTACK_KEY'];
    print(secret);
    final response = await dio.post(
      APIPathHelper.paymentAPIs(APIPath.paystackTransactionInitiate),
      data: params.toJson(),
      options: Options(headers: {"Authorization": "Bearer $secret"}),
    );
    return response.data;
  }

  @override
  Future verifyTransaction(String reference) async {
    final secret = dotenv.env['PAYSTACK_KEY'];
    final response = await dio.get(
      APIPathHelper.paymentAPIs(APIPath.paystackVerifyTransaction,
          id: reference),
      options: Options(headers: {"Authorization": "Bearer $secret"}),
    );
    return response.data;
  }
}
