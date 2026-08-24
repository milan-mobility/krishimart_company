import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/bottom_sheet_drag_line.dart';
import 'package:krishi_mart/view/base/common_button.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  const ConfirmationBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.onPositive,
    required this.txtPositive,
  });

  final String title;
  final String description;
  final VoidCallback onPositive;
  final String txtPositive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppResponsive.space(24),
        right: AppResponsive.space(24),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppResponsive.space(24)),
        ),
        color: Colors.white,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Gap(AppResponsive.space(20)),
            const BottomSheetDragLine(),
            Gap(AppResponsive.space(26)),
            Column(
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: interW600.copyWith(
                    fontSize: AppResponsive.font(20),
                    color: AppColors.color262626,
                  ),
                ),
                Gap(AppResponsive.space(24)),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: interW500.copyWith(
                    fontSize: AppResponsive.font(16),
                    color: AppColors.color797979,
                  ),
                ),
                Gap(AppResponsive.space(40)),
                Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        width: double.infinity,
                        btnText: 'Cancel'.tr,
                        onPressed: () => Get.back(),
                        btnBgColor: AppColors.white,
                        btnTxtColor: AppColors.themeColor,
                        side: const BorderSide(
                          color: AppColors.themeColor,
                          width: 1,
                        ),
                      ),
                    ),
                    Gap(AppResponsive.space(15)),
                    Expanded(
                      child: CommonButton(
                        width: double.infinity,
                        btnText: txtPositive,
                        onPressed: () => onPositive.call(),
                      ),
                    ),
                  ],
                ),
                Gap(AppResponsive.space(20)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
