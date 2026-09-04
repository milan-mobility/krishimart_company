import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/view/screens/company/home/controller/company_home_controller.dart';
import 'package:krishi_mart/view/screens/company/home/widgets/company_recent_products_section.dart';
import 'package:krishi_mart/view/screens/dealer/home/widgets/dealer_dashboard_stat_card.dart';

class CompanyDashboardContent extends StatelessWidget {
  const CompanyDashboardContent({required this.controller, super.key});

  final CompanyHomeController controller;

  @override
  Widget build(final BuildContext context) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.hasError) {
      return Center(
        child: TextButton(
          onPressed: controller.getCompanyDashboard,
          child: Text('Retry'.tr),
        ),
      );
    }

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            DealerDashboardStatCard(
              value: '${controller.dashboard?.totalProducts ?? 0}',
              label: 'Products',
              icon: Assets.svg.icProducts,
              color: AppColors.dashboardStatGreen,
            ),
            const SizedBox(width: 10),
            DealerDashboardStatCard(
              value: '${controller.totalViews}',
              label: 'Views',
              icon: Assets.svg.icViews,
              color: AppColors.dashboardStatOrange,
            ),
          ],
        ),
        Gap(AppResponsive.value(26, tablet: 32)),
        CompanyRecentProductsSection(products: controller.recentProducts),
      ],
    );
  }
}
