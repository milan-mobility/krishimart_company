import 'package:get/get.dart';
import 'package:krishi_mart/view/screens/company/product/list/controller/product_controller.dart';

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductListController>(ProductListController.new);
  }
}
