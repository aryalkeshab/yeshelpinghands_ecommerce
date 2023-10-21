import '../../../../core/data/data_source/remote/api_result.dart';
import '../../data/models/request/login_params.dart';

abstract class PasswordResetRepository {
  //return type string is for any success message from backend
  Future<ApiResponse> resetPassword({required String email});
}
