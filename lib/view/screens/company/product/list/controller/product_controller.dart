import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/data/network/api_end_points.dart';
import 'package:krishi_mart/data/network/connection.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/product_repo.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/app_enums.dart';
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/loader.dart';
import 'package:krishi_mart/view/screens/dealer/product/edit_product/edit_dealer_product_screen.dart';

class ProductListController extends GetxController {
  ProductListController(this.sharedPref, this.productRepo);

  final SharedPreferenceHelper sharedPref;
  final ProductRepo productRepo;
  bool _hasNextPage = true;

  late final PagingController<int, Product> pagingController =
      PagingController<int, Product>(
        getNextPageKey: (final PagingState<int, Product> state) =>
            _hasNextPage ? state.nextIntPageKey : null,
        fetchPage: _fetchProductsPage,
      );

  Future<List<Product>> _fetchProductsPage(final int pageKey) async {
    final ProductModel response = await productRepo.getProducts(
      <String, dynamic>{'page': pageKey, 'per_page': 5},
      sharedPref.getUserRole,
    );
    _hasNextPage = response.data?.nextPageUrl != null;
    return response.data?.data ?? <Product>[];
  }

  Future<void> refreshProducts() async {
    _hasNextPage = true;
    pagingController.refresh();
  }

  Future<void> deleteProduct(int productId) async {
    final bool isInternetAvailable = await ConnectionUtils.isNetworkConnected();
    if (!isInternetAvailable) {
      showErrorSnackBar(
        title: MessageConstant.netWorkTitle,
        message: MessageConstant.networkError,
      );
      return;
    }

    try {
      Loader.load(true);
      final bool value = await productRepo.deleteProduct(
        productId,
        sharedPref.getUserRole,
      );
      if (value) {
        Get.back();
        await refreshProducts();
        showSuccessSnackBar(message: 'Product deleted successfully'.tr);
      } else {
        showErrorSnackBar(message: 'Something went wrong!'.tr);
      }
    } on DioException catch (error) {
      Utility.showAPIError(error);
    } catch (error) {
      debugPrint('EXCEPTION=>${error.toString()}');
    } finally {
      Loader.load(false);
    }
  }

  void editProduct(final Product product) {
    if (sharedPref.getUserRole == UserType.dealer.name) {
      Get.toNamed(RouteHelper.editDealerProduct, arguments: product);
    } else {
      Get.to(
        () => EditDealerProductScreen(
          product: product,
          updateEndpoint: Endpoints.updateCompanyProduct(product.id ?? 0),
        ),
      );
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
