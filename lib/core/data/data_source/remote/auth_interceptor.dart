import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response;
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/toast.dart';

import '../../../../features/auth/presentation/controller/auth_controller.dart';
import '../local/storage_constants.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Dio _dio;
  final FlutterSecureStorage storage;

  AuthInterceptor(this._dio, this.storage);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    if (err.response?.statusCode == 401) {
      logout();
    }
    return handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['requiresToken'] == false) {
      return handler.next(options);
    } else {
      final accessToken = await storage.read(key: StorageConstants.accessToken);
      if (options.headers['allowInvalid'] == true) {
        options.headers.addAll(
          <String, String>{'Authorization': 'Bearer $accessToken'},
        );
        return handler.next(options);
      } else {
        if (accessToken == null) {
          final error = DioError(
            requestOptions: options,
            type: DioErrorType.badResponse,
            response: Response(
                requestOptions: options, statusMessage: "Unauthorized"),
          );

          return handler.reject(error);
        }
        options.headers.addAll(
          <String, String>{'Authorization': 'Bearer $accessToken'},
        );
        return handler.next(options);
      }
    }
  }

  void logout() {
    showToast("Token expired. Please login again",
        color: Colors.red, isCenter: true);
    Get.find<AuthController>().logout();
    Get.key.currentState
        ?.popUntil((route) => route.settings.name == Routes.dashboard);
  }
}
