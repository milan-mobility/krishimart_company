import 'package:get/get.dart';
import 'package:krishi_mart/data/controllers/loader_controller.dart';

class Loader {
  static final LoaderController _controller = Get.find();

  static void load(bool value) {
    if (value) {
      _controller.show();
    } else {
      _controller.hide();
    }
  }
}
