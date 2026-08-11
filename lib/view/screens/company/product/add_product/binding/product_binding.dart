import 'package:get/get.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/controller/add_product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProductController>(AddProductController.new);
  }
}
