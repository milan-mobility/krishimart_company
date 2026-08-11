import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/screens/dealer/home/controller/dealer_home_controller.dart';

class DealerBannerCarousel extends StatelessWidget {
  const DealerBannerCarousel({required this.controller, super.key});

  final DealerHomeController controller;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppResponsive.value(10, tablet: 14)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppResponsive.value(14, tablet: 18),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.themeColor.withValues(alpha: .06),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: AppResponsive.value(138, tablet: 164),
            child: PageView.builder(
              controller: controller.bannerPageController,
              itemCount: controller.bannerTitles.length,
              onPageChanged: controller.onBannerChanged,
              itemBuilder: (final BuildContext context, final int index) {
                return Container(
                  padding: EdgeInsets.all(AppResponsive.value(18, tablet: 22)),
                  decoration: BoxDecoration(
                    color: AppColors.dashboardBanner,
                    borderRadius: BorderRadius.circular(
                      AppResponsive.value(9, tablet: 12),
                    ),
                  ),
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          controller.bannerTitles[index].tr,
                          style: interW700.copyWith(
                            fontSize: AppResponsive.font(16),
                            color: AppColors.color1F6D1A,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.color1F6D1A,
                        size: AppResponsive.value(20),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Gap(AppResponsive.value(10, tablet: 12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(controller.bannerTitles.length, (
              final int index,
            ) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: AppResponsive.value(
                  controller.currentBanner == index ? 18 : 6,
                ),
                height: AppResponsive.value(6),
                margin: EdgeInsets.symmetric(
                  horizontal: AppResponsive.value(3),
                ),
                decoration: BoxDecoration(
                  color: controller.currentBanner == index
                      ? AppColors.themeColor
                      : AppColors.colorC1C8C2,
                  borderRadius: BorderRadius.circular(AppResponsive.value(5)),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
