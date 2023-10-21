import 'package:yeshelpinghand/features/auth/data/models/request/update_password_params.dart';

abstract class PasswordUpdateRepository {
  Future<dynamic> updatePassword(UpdatePasswordParams updatePasswordParams);
}
