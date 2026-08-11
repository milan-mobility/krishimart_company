import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/view/screens/dealer/home/controller/dealer_home_controller.dart';
import 'package:krishi_mart/view/screens/dealer/home/widgets/dealer_banner_carousel.dart';
import 'package:krishi_mart/view/screens/dealer/home/widgets/dealer_dashboard_stat_card.dart';
import 'package:krishi_mart/view/screens/dealer/home/widgets/dealer_home_header.dart';
import 'package:krishi_mart/view/screens/dealer/home/widgets/dealer_products_section.dart';

class DealerHomeScreen extends GetView<DealerHomeController> {
  const DealerHomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.productSurface,
      body: GetBuilder<DealerHomeController>(
        builder: (final DealerHomeController controller) {
          return Column(
            children: <Widget>[
              DealerHomeHeader(dealerName: controller.dealerName),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppResponsive.value(16, tablet: 28)),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: AppResponsive.contentWidth,
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            DealerDashboardStatCard(
                              value: '12',
                              label: 'Products',
                              icon: Icons.eco_outlined,
                              color: AppColors.dashboardStatGreen,
                            ),
                            SizedBox(width: 10),
                            DealerDashboardStatCard(
                              value: '34',
                              label: 'Leads',
                              icon: Icons.phone_outlined,
                              color: AppColors.dashboardStatOrange,
                            ),
                            SizedBox(width: 10),
                            DealerDashboardStatCard(
                              value: 'View',
                              label: '',
                              icon: Icons.star_outline,
                              color: AppColors.dashboardStatMint,
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
    );
  }
}
