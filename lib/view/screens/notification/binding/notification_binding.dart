import 'package:get/get.dart';
import 'package:krishi_mart/view/screens/notification/controller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(Get.find()),
    );
  }
}
