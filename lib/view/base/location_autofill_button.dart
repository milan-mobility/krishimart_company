import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class LocationAutofillButton extends StatelessWidget {
  const LocationAutofillButton({
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(final BuildContext context) {
    return TextButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.colorB1F0CE,
        foregroundColor: AppColors.themeColor,
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.value(10),
          vertical: AppResponsive.value(4),
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: isLoading
          ? SizedBox(
              width: AppResponsive.value(14),
              height: AppResponsive.value(14),
              child: const CircularProgressIndicator.adaptive(strokeWidth: 2),
            )
          : Icon(Icons.my_location_outlined, size: AppResponsive.value(14)),
      label: Text(
        'Auto-fill'.tr,
        style: interW500.copyWith(fontSize: AppResponsive.font(11)),
      ),
    );
  }
}
