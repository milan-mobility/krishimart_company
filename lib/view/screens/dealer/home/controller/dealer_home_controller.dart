import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart' hide Banner;
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/dashbord_model.dart';
import 'package:krishi_mart/data/model/dealer_banner_model.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/dashboard_repo.dart';
import 'package:krishi_mart/utils/app_enums.dart';

class DealerHomeController extends GetxController implements GetxService {
  DealerHomeController(this.sharedPref, this.dashboardRepo);

  final SharedPreferenceHelper sharedPref;
  final DashboardRepo dashboardRepo;
  final PageController bannerPageController = PageController();
  Dashboard? dashboard;
  List<Banner> banners = <Banner>[];
  bool isLoading = false;
  bool hasError = false;

  Timer? _bannerTimer;
  int currentBanner = 0;

  String get dealerName => sharedPref.getUserInfo?.name ?? '';
  List<Product> get recentProducts => dashboard?.recentProducts ?? <Product>[];
  int get totalViews =>
      dashboard?.totalViews ??
      recentProducts.fold<int>(
        0,
        (final int total, final Product product) =>
            total + (product.views ?? 0),
      );

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    isLoading = true;
    hasError = false;
    update();

    try {
      final List<dynamic> responses =
          await Future.wait<dynamic>(<Future<dynamic>>[
            dashboardRepo.getCompanyDashboard(UserType.dealer.name),
            dashboardRepo.getBanners(UserType.dealer.name),
          ]);
      dashboard = (responses[0] as DashboardModel).data;
      banners = (responses[1] as DealerBannerModel).data ?? <Banner>[];
      currentBanner = 0;
      _startBannerAutoSlide();
    } on DioException {
      hasError = true;
    } catch (_) {
      hasError = true;
    } finally {
      isLoading = false;
      update();
    }
  }

  void _startBannerAutoSlide() {
    _bannerTimer?.cancel();
    if (banners.length < 2) return;
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!bannerPageController.hasClients) return;
      final int nextPage = (currentBanner + 1) % banners.length;
      bannerPageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  void onBannerChanged(final int index) {
    currentBanner = index;
    update();
  }

  @override
  void onClose() {
    _bannerTimer?.cancel();
    bannerPageController.dispose();
    super.onClose();
  }
}
