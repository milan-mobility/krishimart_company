import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/common_button.dart';

class CurrentLocationConfirmationDialog extends StatelessWidget {
  const CurrentLocationConfirmationDialog({
    required this.profileType,
    super.key,
  });

  final String profileType;

  static Future<bool> show({required final String profileType}) async {
    return await Get.dialog<bool>(
          CurrentLocationConfirmationDialog(profileType: profileType),
          barrierDismissible: false,
        ) ??
        false;
  }

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppResponsive.value(18)),
      ),
      contentPadding: EdgeInsets.all(AppResponsive.value(22)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.location_searching_outlined,
            color: AppColors.themeColor,
            size: AppResponsive.value(38),
          ),
          Gap(AppResponsive.value(14)),
          Text(
            'Unable to confirm your entered location'.tr,
            textAlign: TextAlign.center,
            style: interW600.copyWith(
              fontSize: AppResponsive.font(18),
              color: AppColors.color1A1A2D,
            ),
          ),
          Gap(AppResponsive.value(10)),
          Text(
            '${'We could not find coordinates for this address. Use your current location as your'.tr} ${profileType.tr} ${'location?'.tr}',
            textAlign: TextAlign.center,
            style: companyProfileUploadDescription,
          ),
          Gap(AppResponsive.value(8)),
          Text(
            'For best accuracy, complete your profile while you are at your business location.'
                .tr,
            textAlign: TextAlign.center,
            style: companyProfileUploadDescription,
          ),
          Gap(AppResponsive.value(22)),
          Row(
            children: <Widget>[
              Expanded(
                child: CommonButton(
                  btnText: 'Not now'.tr,
                  btnBgColor: AppColors.white,
                  btnTxtColor: AppColors.themeColor,
                  side: const BorderSide(color: AppColors.themeColor),
                  onPressed: () => Get.back(result: false),
                ),
              ),
              Gap(AppResponsive.value(10)),
              Expanded(
                child: CommonButton(
                  btnText: 'Use Current Location'.tr,
                  onPressed: () => Get.back(result: true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
