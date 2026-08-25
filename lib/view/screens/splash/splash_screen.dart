import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/screens/splash/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        init: SplashController(Get.find()),
        builder: (final SplashController controller) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.colorF0F7F2,
                  AppColors.white,
                  AppColors.colorE8F3EC,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(AppResponsive.value(50, tablet: 65)),
                Image.asset(
                  Assets.png.icSplashLogo.path,
                  height: AppResponsive.value(
                    250,
                    tablet: 275,
                    largeTablet: 300,
                  ),
                  width: AppResponsive.value(
                    250,
                    tablet: 275,
                    largeTablet: 300,
                  ),
                ),
                Gap(AppResponsive.value(5, tablet: 8)),
                Text(
                  'Smart Agriculture Marketplace'.tr,
                  style: interW500.copyWith(
                    fontSize: 16,
                    color: AppColors.color414844,
                  ),
                ),
                Gap(AppResponsive.value(100, tablet: 70)),
                CircularProgressIndicator(
                  value: controller.progress,
                  strokeWidth: 4,
                  padding: EdgeInsets.all(AppResponsive.value(30, tablet: 45)),
                  color: AppColors.color2D5A27,
                  backgroundColor: AppColors.color2D5A27.withValues(alpha: .2),
                ),
                Gap(AppResponsive.value(20, tablet: 70)),
                Text(
                  'SECURE DATA HUB'.tr,
                  style: interW500.copyWith(
                    fontSize: 14,
                    color: AppColors.color717973,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
