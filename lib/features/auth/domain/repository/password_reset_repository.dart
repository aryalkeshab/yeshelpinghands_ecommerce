import '../../../../core/data/data_source/remote/api_result.dart';

abstract class PasswordResetRepository {
  //return type string is for any success message from backend
  Future<ApiResponse> resetPassword({required String email});
}
