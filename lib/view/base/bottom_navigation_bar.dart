import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/routes/route_helper.dart';

import '../../gen/assets.gen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({this.selectedIndex, super.key});

  final int? selectedIndex;

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorECEEED,
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
          topLeft: Radius.circular(AppResponsive.space(12)),
          topRight: Radius.circular(AppResponsive.space(12)),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.colorA4F792,
          unselectedItemColor: AppColors.color414844,
          showUnselectedLabels: true,
          currentIndex: selectedIndex ?? 0,
          selectedLabelStyle: interW500.copyWith(
            fontSize: AppResponsive.font(12),
            color: AppColors.colorA4F792,
          ),
          unselectedLabelStyle: interW500.copyWith(
            fontSize: AppResponsive.font(12),
            color: AppColors.color414844,
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.svg.icHome),
              activeIcon: SvgPicture.asset(Assets.svg.icHome),
              label: 'Home'.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.svg.icMenuVideo),
              activeIcon: SvgPicture.asset(Assets.svg.icMenuVideo),
              label: 'Reels'.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.svg.icMenuVideo),
              activeIcon: SvgPicture.asset(Assets.svg.icMenuVideo),
              label: 'Videos'.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.svg.icMenuProfile),
              activeIcon: SvgPicture.asset(Assets.svg.icMenuProfile),
              label: 'Profile'.tr,
            ),
          ],
          onTap: (final int index) {
            switch (index) {
              case 0:
                if (Get.currentRoute != RouteHelper.home) {
                  Get.offAndToNamed(RouteHelper.home);
                }
                break;
              case 1:
                if (Get.currentRoute != RouteHelper.reels) {
                  Get.offAndToNamed(RouteHelper.reels);
                }
                break;
              case 2:
                if (Get.currentRoute != RouteHelper.videos) {
                  Get.offAndToNamed(RouteHelper.videos);
                }
                break;
              case 3:
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
