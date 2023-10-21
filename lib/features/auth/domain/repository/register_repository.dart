import 'package:yeshelpinghand/features/auth/data/models/request/register_params.dart';

import '../../../../core/data/data_source/remote/api_result.dart';

abstract class RegisterRepository {
  //return type string is for any success message from backend
  Future<ApiResponse> register(RegisterParams loginParams);
}
