import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/app_enums.dart';
import 'package:krishi_mart/view/base/bottom_navigation_bar.dart';
import 'package:krishi_mart/view/base/common_appbar.dart';
import 'package:krishi_mart/view/base/confirmation_bottom_sheet.dart';
import 'package:krishi_mart/view/screens/company/product/list/controller/product_controller.dart';
import 'package:krishi_mart/view/screens/company/product/list/widgets/product_row.dart';

import '../../../../../gen/assets.gen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ProductListController>(
      init: ProductListController(Get.find(), Get.find()),
      builder: (final ProductListController controller) {
        return Scaffold(
          backgroundColor: AppColors.productSurface,
          bottomNavigationBar: BottomNavigation(selectedIndex: 1),
          appBar: CommonAppbar(
            title: 'Product'.tr,
            backgroundColor: AppColors.themeColor,
            txtColor: AppColors.white,
            iconStr: Assets.svg.icProduct,
            leadingIconColor: Colors.white,
          ),
          body: RefreshIndicator(
            onRefresh: controller.refreshProducts,
            child: PagingListener<int, Product>(
              controller: controller.pagingController,
              builder:
                  (
                    final BuildContext context,
                    final PagingState<int, Product> state,
                    final VoidCallback fetchNextPage,
                  ) {
                    return PagedListView<int, Product>.separated(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      padding: EdgeInsets.all(
                        AppResponsive.value(16, tablet: 28),
                      ),
                      builderDelegate: PagedChildBuilderDelegate<Product>(
                        itemBuilder:
                            (
                              final BuildContext context,
                              final Product product,
                              final int index,
                            ) {
                              return ProductRow(
                                product: product,
                                sharedPref: controller.sharedPref,
                                onEdit: () => controller.editProduct(product),
                                onDelete: () {
                                  Get.bottomSheet(
                                    ConfirmationBottomSheet(
                                      title: 'Delete Product'.tr,
                                      description:
                                          'Are you sure you want to delete this product?'
                                              .tr,
                                      onPositive: () {
                                        controller.deleteProduct(
                                          product.id ?? 0,
                                        );
                                      },
                                      txtPositive: 'Yes,Delete'.tr,
                                    ),
                                  );
                                },
                              );
                            },
                        firstPageProgressIndicatorBuilder: (_) =>
                            const Center(child: CircularProgressIndicator()),
                        newPageProgressIndicatorBuilder: (_) => const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        noItemsFoundIndicatorBuilder: (_) =>
                            Center(child: Text('No products found'.tr)),
                      ),
                      separatorBuilder: (_, index) =>
                          SizedBox(height: AppResponsive.value(14, tablet: 18)),
                    );
                  },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (controller.sharedPref.getUserRole == UserType.company.name) {
                Get.toNamed(RouteHelper.addProduct);
              } else {
                Get.toNamed(RouteHelper.addDealerProduct);
              }
            },
            backgroundColor: AppColors.themeColor,
            foregroundColor: AppColors.white,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
