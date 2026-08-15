import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/dealer_dashboard_product.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';

class DealerHomeController extends GetxController implements GetxService {
  DealerHomeController(this.sharedPref);

  final SharedPreferenceHelper sharedPref;
  final PageController bannerPageController = PageController();
  final List<String> bannerTitles = <String>[
    'Boost your product visibility',
    'Grow your dealer network',
    'Manage your leads easily',
  ];
  final List<DealerDashboardProduct> products = <DealerDashboardProduct>[
    const DealerDashboardProduct(
      name: 'Ampligo',
      category: 'Insecticide',
      quantity: '1 Ltr',
      price: '₹1,250',
    ),
    const DealerDashboardProduct(
      name: 'Urea Gold',
      category: 'Fertilizer',
      quantity: '50Kg',
      price: '₹266',
    ),
  ];

  Timer? _bannerTimer;
  int currentBanner = 0;

  String get dealerName => sharedPref.getUserInfo?.name ?? 'Dealer';

  @override
  void onInit() {
    super.onInit();
    _startBannerAutoSlide();
  }

  void _startBannerAutoSlide() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!bannerPageController.hasClients) return;
      final int nextPage = (currentBanner + 1) % bannerTitles.length;
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
