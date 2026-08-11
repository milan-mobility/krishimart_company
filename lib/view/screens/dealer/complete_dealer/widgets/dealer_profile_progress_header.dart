import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class DealerProfileProgressHeader extends StatelessWidget {
  const DealerProfileProgressHeader({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Step 2 of 3'.tr,
              style: interW600.copyWith(
                fontSize: AppResponsive.font(12),
                color: AppColors.color1F6D1A,
              ),
            ),
            Text(
              'Profile Completion: 66%'.tr,
              style: companyProfileUploadDescription,
            ),
          ],
        ),
        Gap(AppResponsive.value(8, tablet: 10)),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppResponsive.value(6)),
          child: const LinearProgressIndicator(
            value: .66,
            minHeight: 6,
            color: AppColors.color1F6D1A,
            backgroundColor: AppColors.colorECEEED,
          ),
        ),
      ],
    );
  }
}
