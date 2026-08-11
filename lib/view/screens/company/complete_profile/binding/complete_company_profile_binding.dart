import 'package:get/get.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/controller/complete_company_profile_controller.dart';

class CompleteCompanyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteCompanyProfileController>(
      () => CompleteCompanyProfileController(Get.find(), Get.find()),
    );
  }
}
