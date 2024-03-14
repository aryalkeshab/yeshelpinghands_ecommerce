import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/local/auth_local_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authLocalDataSource,
    required this.authRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<bool> isAuthenticated() async {
    return authLocalDataSource.isAuthenticated();
  }

  @override
  Future<void> logout() async {
    try {
      await authRemoteDataSource.logout();
    } catch (e) {}
    return authLocalDataSource.clearToken();
  }
}
