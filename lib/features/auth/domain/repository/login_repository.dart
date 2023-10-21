
import '../../../../core/data/data_source/remote/api_result.dart';
import '../../data/models/request/login_params.dart';

abstract class LoginRepository {
  //return type string is for any success message from backend
  Future<ApiResponse> login(LoginParams loginParams);
  Future<ApiResponse> loginWithGoogle();
  Future<ApiResponse> loginWithFacebook();
}
