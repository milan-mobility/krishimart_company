import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class RoleOptionCard extends StatelessWidget {
  const RoleOptionCard({
    required this.title,
    required this.description,
    required this.iconAsset,
    required this.color,
    required this.iconBackgroundColor,
    required this.onTap,
    super.key,
  });

  final String title;
  final String description;
  final String iconAsset;
  final Color color;
  final Color iconBackgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppResponsive.value(24, tablet: 28)),
      child: Container(
        constraints: BoxConstraints(
          minHeight: AppResponsive.value(112, tablet: 128),
        ),
        padding: EdgeInsets.all(AppResponsive.value(12, tablet: 16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppResponsive.value(20, tablet: 26),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.black.withValues(alpha: .05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: AppResponsive.value(72, tablet: 84),
              height: AppResponsive.value(72, tablet: 84),
              padding: EdgeInsets.all(AppResponsive.value(10, tablet: 12)),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(
                  AppResponsive.value(16, tablet: 20),
                ),
              ),
              child: Image.asset(iconAsset, fit: BoxFit.contain),
            ),
            SizedBox(width: AppResponsive.value(16, tablet: 20)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title.tr,
                    style: userRoleOptionTitle.copyWith(color: color),
                  ),
                  SizedBox(height: AppResponsive.value(3, tablet: 5)),
                  Text(description.tr, style: userRoleOptionDescription),
                ],
              ),
            ),
            Container(
              width: AppResponsive.value(44, tablet: 50),
              height: AppResponsive.value(44, tablet: 50),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                Assets.svg.icNext,
                width: AppResponsive.value(12, tablet: 14),
                height: AppResponsive.value(12, tablet: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
