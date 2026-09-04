import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/bottom_sheet_drag_line.dart';
import 'package:krishi_mart/view/base/common_button.dart';

class LocationSettingsBottomSheet extends StatelessWidget {
  const LocationSettingsBottomSheet({
    required this.message,
    required this.onOpenSettings,
    super.key,
  });

  final String message;
  final Future<void> Function() onOpenSettings;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppResponsive.space(24),
        AppResponsive.space(20),
        AppResponsive.space(24),
        AppResponsive.space(24),
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetDragLine(),
            Gap(AppResponsive.space(24)),
            Icon(
              Icons.location_off_outlined,
              size: AppResponsive.value(36),
              color: AppColors.themeColor,
            ),
            Gap(AppResponsive.space(16)),
            Text('Location Access'.tr, style: interW600),
            Gap(AppResponsive.space(10)),
            Text(
              message.tr,
              textAlign: TextAlign.center,
              style: companyProfileUploadDescription,
            ),
            Gap(AppResponsive.space(24)),
            CommonButton(
              width: double.infinity,
              btnText: 'Open Settings'.tr,
              onPressed: () async {
                await onOpenSettings();
                Get.back();
              },
            ),
            Gap(AppResponsive.space(10)),
            CommonButton(
              width: double.infinity,
              btnText: 'Cancel'.tr,
              btnBgColor: AppColors.white,
              btnTxtColor: AppColors.themeColor,
              side: const BorderSide(color: AppColors.themeColor),
              onPressed: Get.back,
            ),
          ],
        ),
      ),
    );
  }
}
