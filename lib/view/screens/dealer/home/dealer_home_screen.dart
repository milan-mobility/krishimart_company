import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/controllers/common_controller.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/view/base/bottom_navigation_bar.dart';
import 'package:krishi_mart/view/screens/dealer/home/controller/dealer_home_controller.dart';
import 'package:krishi_mart/view/screens/dealer/home/widgets/dealer_banner_carousel.dart';
import 'package:krishi_mart/view/screens/dealer/home/widgets/dealer_dashboard_stat_card.dart';
import 'package:krishi_mart/view/screens/dealer/home/widgets/dealer_home_header.dart';
import 'package:krishi_mart/view/screens/dealer/home/widgets/dealer_products_section.dart';

import '../../../../gen/assets.gen.dart';

class DealerHomeScreen extends StatelessWidget {
  const DealerHomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.productSurface,
        bottomNavigationBar: BottomNavigation(selectedIndex: 0),
        body: GetBuilder<DealerHomeController>(
          builder: (final DealerHomeController controller) {
            return Column(
              children: <Widget>[
                GetBuilder<CommonController>(
                  builder: (final CommonController commonController) {
                    return DealerHomeHeader(
                      dealerName:
                          commonController
                              .userProfileModel
                              ?.data
                              ?.profile
                              ?.shopName ??
                          '',
                    );
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(
                      AppResponsive.value(16, tablet: 28),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: AppResponsive.contentWidth,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              DealerDashboardStatCard(
                                value: '12',
                                label: 'Products',
                                icon: Assets.svg.icProducts,
                                color: AppColors.dashboardStatGreen,
                              ),
                              SizedBox(width: 10),
                              DealerDashboardStatCard(
                                value: '29',
                                label: 'Views',
                                icon: Assets.svg.icViews,
                                color: AppColors.dashboardStatOrange,
                              ),
                            ],
                          ),
                          Gap(AppResponsive.value(24, tablet: 30)),
                          DealerBannerCarousel(controller: controller),
                          Gap(AppResponsive.value(26, tablet: 32)),
                          DealerProductsSection(products: controller.products),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
