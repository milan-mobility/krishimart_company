import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class RoleSelectionHeaderWidget extends StatelessWidget {
  const RoleSelectionHeaderWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          Assets.png.icSplashLogo.path,
          width: AppResponsive.value(150, tablet: 200),
          height: AppResponsive.value(150, tablet: 200),
        ),
        Gap(AppResponsive.value(8, tablet: 12)),
        // Text('iFarm Connect'.tr, style: userRoleTitle),
        // Gap(AppResponsive.value(14, tablet: 18)),
        Text(
          'Farmers’ trust, our platform'.tr,
          textAlign: TextAlign.center,
          style: interW500.copyWith(
            fontSize: AppResponsive.font(14),
            color: AppColors.color2D5A27,
          ),
        ),
        Gap(AppResponsive.value(15, tablet: 20)),
        Text('Welcome to iFarm Connect'.tr, style: userRoleWelcome),
        Gap(AppResponsive.value(7, tablet: 10)),
        Text('Please select your role to continue'.tr, style: userRoleSubtitle),
      ],
    );
  }
}
