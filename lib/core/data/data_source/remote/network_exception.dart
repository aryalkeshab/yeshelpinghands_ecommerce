import 'dart:io';

import 'package:dio/dio.dart';

abstract class NetworkException {
  NetworkException();

  factory NetworkException.noInternetConnection() => _NoInternetConnection();

  factory NetworkException.badRequest() => _BadRequest();

  factory NetworkException.internalServerError() => _InternalServerError();

  factory NetworkException.unexpectedError() => _UnExpectedError();

  factory NetworkException.defaultError({String? value}) =>
      _DefaultError(value: value);

  factory NetworkException.unauthorizedRequest() => _UnauthorizedRequest();

  static NetworkException handleResponseError(DioError error) {
    switch (error.response?.statusCode) {
      case 401:
        return NetworkException.unauthorizedRequest();
      case 404:
        return NetworkException.defaultError(
            value: error.response?.data[0]["error"]);

      case 500:
        return NetworkException.internalServerError();
      default:
        return NetworkException.defaultError();
    }
  }

  static NetworkException getException(error) {
    NetworkException networkException;
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.unknown:
          networkException = NetworkException.defaultError();
          break;
        case DioErrorType.badResponse:
          networkException = handleResponseError(error);
          break;
        default:
          networkException = NetworkException.defaultError();
      }
    } else if (error is SocketException) {
      networkException = NetworkException.noInternetConnection();
    } else {
      networkException = NetworkException.unexpectedError();
    }
    return networkException;
  }

  static String getErrorMessage(NetworkException networkException) {
    var errorMessage = "";
    switch (networkException.runtimeType) {
      case _NoInternetConnection:
        errorMessage = NetworkExceptionMessage.NO_INTERNET_CONNECTION;
        break;
      case _DefaultError:
        errorMessage =
            (networkException as _DefaultError).value ?? "Something went wrong";
        break;
      case _UnExpectedError:
        errorMessage = "Unexpected error occurred";
        break;
      case _UnauthorizedRequest:
        errorMessage = "Please login first";
        break;
      default:
        errorMessage = "";
    }
    return errorMessage;
  }
}

class _NoInternetConnection extends NetworkException {
  _NoInternetConnection();
}

class _BadRequest extends NetworkException {}

class _InternalServerError extends NetworkException {}

class _UnExpectedError extends NetworkException {}

class _DefaultError extends NetworkException {
  String? value;

  _DefaultError({this.value});
}

class _UnauthorizedRequest extends NetworkException {}

class NetworkExceptionMessage {
  static const NO_INTERNET_CONNECTION = "No Internet Connection";
  static const TOKEN_EXPIRED = "Token expired. Please login to continue";
}
