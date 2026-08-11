import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/view/base/common_appbar.dart';
import 'package:krishi_mart/view/screens/company/product/list/controller/product_controller.dart';
import 'package:krishi_mart/view/screens/company/product/list/widgets/product_row.dart';

class ProductListScreen extends GetView<ProductListController> {
  const ProductListScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.productSurface,
      appBar: CommonAppbar(
        title: 'Product'.tr,
        backgroundColor: AppColors.themeColor,
        txtColor: AppColors.white,
        leadingIconColor: AppColors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: AppColors.white),
          ),
        ],
      ),
      body: GetBuilder<ProductListController>(
        builder: (final ProductListController controller) {
          return ListView.separated(
            padding: EdgeInsets.all(AppResponsive.value(16, tablet: 28)),
            itemCount: controller.products.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: AppResponsive.value(14, tablet: 18)),
            itemBuilder: (final BuildContext context, final int index) {
              final product = controller.products[index];
              return ProductRow(
                product: product,
                onEdit: () => controller.editProduct(product),
                onDelete: () => controller.deleteProduct(product),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteHelper.product),
        backgroundColor: AppColors.themeColor,
        foregroundColor: AppColors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
