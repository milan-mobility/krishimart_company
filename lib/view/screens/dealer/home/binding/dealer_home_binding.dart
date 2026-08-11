import 'package:get/get.dart';
import 'package:krishi_mart/view/screens/dealer/home/controller/dealer_home_controller.dart';

class DealerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DealerHomeController>(() => DealerHomeController(Get.find()));
  }
}
