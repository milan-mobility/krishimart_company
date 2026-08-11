import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class ProductRowAction extends StatelessWidget {
  const ProductRowAction({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppResponsive.value(7)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppResponsive.value(7)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.value(8),
            vertical: AppResponsive.value(5),
          ),
          child: Row(
            children: <Widget>[
              Icon(icon, color: foregroundColor, size: AppResponsive.value(12)),
              Gap(AppResponsive.value(3)),
              Text(
                label.tr,
                style: interW600.copyWith(
                  fontSize: AppResponsive.font(10),
                  color: foregroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
