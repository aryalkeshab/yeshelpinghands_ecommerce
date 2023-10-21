import 'package:get/get.dart';
import 'package:yeshelpinghand/features/crm/presentation/controllers/contact_us_controller.dart';

class ContactUsBindings extends Bindings {
  @override
  void dependencies() {
    Get..put(ContactUsController());
  }
}
