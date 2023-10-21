import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/paystack/data/model/request/paystack_initate_params.dart';
import 'package:yeshelpinghand/features/paystack/data/model/response/paystack_verify_transaction_model.dart';
import 'package:yeshelpinghand/features/paystack/data/source/paystack_data_source.dart';
import 'package:yeshelpinghand/features/paystack/domain/paystack_repository.dart';

import '../../../../core/data/data_source/local/storage_constants.dart';
import '../../../../core/data/data_source/remote/network_exception.dart';

class PaystackRepositoryImpl implements PaystackRepository {
  final NetworkInfo networkInfo;
  final PaystackDataSource paystackDataSource;
  final FlutterSecureStorage secureStorage;

  PaystackRepositoryImpl(
      {required this.paystackDataSource,
      required this.networkInfo,
      required this.secureStorage});

  @override
  Future<ApiResponse> initiateTransaction(PaystackInitiateParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await paystackDataSource.initiateTransaction(params);
        final url = result['data']['authorization_url'];
        return ApiResponse(data: url);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> verifyTransaction(String reference) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await paystackDataSource.verifyTransaction(reference);
        final transactionVerifyModel =
            PaystackVerifyTransactionModel.fromJson(result);
        return ApiResponse(data: transactionVerifyModel);
      } catch (e) {
        if (e is DioError && e.error == DioErrorType.badResponse) {
          return ApiResponse(error: NetworkException.getException(e));
        }
        return ApiResponse(
            error: NetworkException.defaultError(value: e.toString()));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
