import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/view/base/bottom_navigation_bar.dart';
import 'package:krishi_mart/view/screens/company/home/controller/company_home_controller.dart';
import 'package:krishi_mart/view/screens/company/home/widgets/company_dashboard_content.dart';
import 'package:krishi_mart/view/screens/dealer/home/widgets/dealer_home_header.dart';

class CompanyHomeScreen extends StatelessWidget {
  const CompanyHomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    if (!Get.isRegistered<CompanyHomeController>()) {
      Get.put<CompanyHomeController>(
        CompanyHomeController(Get.find(), Get.find()),
        permanent: true,
      );
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.productSurface,
        bottomNavigationBar: BottomNavigation(selectedIndex: 0),
        body: GetBuilder<CompanyHomeController>(
          builder: (final CompanyHomeController controller) {
            return Column(
              children: <Widget>[
                DealerHomeHeader(dealerName: controller.companyName),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: controller.getCompanyDashboard,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.all(
                        AppResponsive.value(16, tablet: 28),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: AppResponsive.contentWidth,
                          minHeight: MediaQuery.sizeOf(context).height,
                        ),
                        child: CompanyDashboardContent(controller: controller),
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
