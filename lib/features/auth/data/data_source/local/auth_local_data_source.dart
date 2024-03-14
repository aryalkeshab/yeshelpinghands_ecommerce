import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../core/data/data_source/local/storage_constants.dart';

abstract class AuthLocalDataSource {
  Future<void> clearToken();

  Future<bool> isAuthenticated();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;

  AuthLocalDataSourceImpl(this._secureStorage);

  @override
  Future<void> clearToken() async {
    await Future.wait([
      _secureStorage.delete(key: StorageConstants.accessToken),
    ]);
  }

  @override
  Future<bool> isAuthenticated() async {
    final accessToken = await _secureStorage.read(key: StorageConstants.accessToken);
    return accessToken != null;
  }
}
