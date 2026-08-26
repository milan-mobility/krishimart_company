import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/app_enums.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({this.selectedIndex, super.key});

  final int? selectedIndex;

  @override
  Widget build(final BuildContext context) {
    final sharedPref = Get.find<SharedPreferenceHelper>();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorECEEED,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppResponsive.value(20)),
          topRight: Radius.circular(AppResponsive.value(20)),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, -1),
            color: AppColors.color1B4332.withValues(alpha: .18),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppResponsive.value(20)),
          topRight: Radius.circular(AppResponsive.value(20)),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.color2D5A27,
          unselectedItemColor: AppColors.color414844,
          showUnselectedLabels: true,
          currentIndex: selectedIndex ?? 0,
          selectedLabelStyle: interW500.copyWith(
            fontSize: AppResponsive.font(15),
            color: AppColors.color2D5A27,
          ),
          unselectedLabelStyle: interW500.copyWith(
            fontSize: AppResponsive.font(14),
            color: AppColors.color414844,
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home), //SvgPicture.asset(Assets.svg.icHome),
              activeIcon: Icon(Icons.home),
              label: 'Home'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.production_quantity_limits,
              ), //SvgPicture.asset(Assets.svg.icProduct),
              activeIcon: Icon(Icons.production_quantity_limits),
              label: 'Product'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ), // SvgPicture.asset(Assets.svg.icMenuProfile),
              activeIcon: Icon(Icons.person),
              label: 'Profile'.tr,
            ),
          ],
          onTap: (final int index) {
            switch (index) {
              case 0:
                if (sharedPref.getUserRole == UserType.company.name) {
                  if (Get.currentRoute != RouteHelper.companyHomeScreen) {
                    Get.offAndToNamed(RouteHelper.companyHomeScreen);
                  }
                } else {
                  if (Get.currentRoute != RouteHelper.dealerHome) {
                    Get.offAndToNamed(RouteHelper.dealerHome);
                  }
                }
                break;
              case 1:
                if (Get.currentRoute != RouteHelper.productList) {
                  Get.offAndToNamed(RouteHelper.productList);
                }
                break;
              case 2:
                if (Get.currentRoute != RouteHelper.profile) {
                  Get.offAndToNamed(RouteHelper.profile);
                }
                break;
            }
          },
        ),
      ),
    );
  }
}
