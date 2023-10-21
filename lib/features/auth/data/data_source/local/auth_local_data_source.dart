import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../core/data/data_source/local/storage_constants.dart';

abstract class AuthLocalDataSource {
  Future<void> clearToken();

  Future<bool> isAuthenticated();

  Future<LoginType> get checkLoginType;
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;

  AuthLocalDataSourceImpl(this._secureStorage);

  @override
  Future<void> clearToken() async {
    await Future.wait([
      _secureStorage.delete(key: StorageConstants.accessToken),
      _secureStorage.delete(key: StorageConstants.socialLoginType)
    ]);
  }

  @override
  Future<bool> isAuthenticated() async {
    final accessToken =
        await _secureStorage.read(key: StorageConstants.accessToken);
    return accessToken != null;
  }

  @override
  Future<LoginType> get checkLoginType async {
    final socialLogin =
        await _secureStorage.read(key: StorageConstants.socialLoginType);

    switch (socialLogin) {
      case "FACEBOOK":
        return LoginType.facebook;
      case "GOOGLE":
        return LoginType.google;

      default:
        return LoginType.emailPassword;
    }
  }
}

enum LoginType { google, facebook, emailPassword }
