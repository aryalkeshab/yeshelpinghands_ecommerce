import 'package:get/get.dart';
import '../../domain/repository/auth_repository.dart';

class AuthController extends GetxController {
  final authRepository = Get.find<AuthRepository>();

  RxBool isLoggedIn = false.obs;

  @override
  onInit() async {
    isLoggedIn.value = await isAuthenticated();
    super.onInit();
  }

  isAuthenticated() async {
    return await authRepository.isAuthenticated();
  }

  void logout() async {
    await authRepository.logout();

    isLoggedIn.value = false;
    // Get.offAndToNamed(Routes.loginPage);
  }

  authorize() async {
    isLoggedIn.value = true;
  }
}
