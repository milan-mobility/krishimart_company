import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class DealerProductTypeTab extends StatelessWidget {
  const DealerProductTypeTab({
    required this.label,
    required this.isSelected,
    required this.isLeftTab,
    super.key,
  });

  final String label;
  final bool isSelected;
  final bool isLeftTab;

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: AppResponsive.value(40),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.themeColor : AppColors.white,
        borderRadius: isLeftTab
            ? BorderRadius.only(
                topLeft: Radius.circular(AppResponsive.value(10)),
                bottomLeft: Radius.circular(AppResponsive.value(10)),
              )
            : BorderRadius.only(
                topRight: Radius.circular(AppResponsive.value(10)),
                bottomRight: Radius.circular(AppResponsive.value(10)),
              ),
      ),
      child: Center(
        child: Text(
          label.tr,
          style: interW500.copyWith(
            fontSize: AppResponsive.font(16),
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}
