import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class DealerDashboardStatCard extends StatelessWidget {
  const DealerDashboardStatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    super.key,
  });

  final String value;
  final String label;
  final String icon;
  final Color color;

  @override
  Widget build(final BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(AppResponsive.value(12, tablet: 16)),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            AppResponsive.value(12, tablet: 16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(icon),
            Gap(AppResponsive.value(7, tablet: 9)),
            Text(
              value,
              style: interW700.copyWith(
                fontSize: AppResponsive.font(22),
                color: AppColors.white,
              ),
            ),
            Text(
              label.tr,
              style: interW500.copyWith(
                fontSize: AppResponsive.font(14),
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
