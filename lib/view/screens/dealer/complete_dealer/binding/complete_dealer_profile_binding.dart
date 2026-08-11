import 'package:get/get.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/controller/complete_dealer_profile_controller.dart';

class CompleteDealerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteDealerProfileController>(
      () => CompleteDealerProfileController(Get.find(), Get.find()),
    );
  }
}
