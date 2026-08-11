import 'package:get/get.dart';
import 'package:krishi_mart/data/model/product_list_item.dart';

class ProductListController extends GetxController {
  final List<ProductListItem> products = <ProductListItem>[
    const ProductListItem(
      name: 'Ampigo 150 ZC',
      company: 'Syngenta',
      views: 131,
    ),
    const ProductListItem(
      name: 'NovaBON',
      company: 'PI Industries',
      views: 164,
    ),
    const ProductListItem(
      name: 'Maxx Drip Kit',
      company: 'Jain Irrigation',
      views: 167,
    ),
    const ProductListItem(name: 'Urea Gold', company: 'IFFCO', views: 74),
    const ProductListItem(name: 'Confidor', company: 'Bayer', views: 165),
  ];

  void editProduct(final ProductListItem product) {
    Get.snackbar('Edit Product'.tr, '${product.name} ${'is ready to edit'.tr}');
  }

  void deleteProduct(final ProductListItem product) {
    products.remove(product);
    update();
    Get.snackbar(
      'Product removed'.tr,
      '${product.name} ${'has been removed'.tr}',
    );
  }
}
