import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class CompanyProfileSectionCard extends StatelessWidget {
  const CompanyProfileSectionCard({
    required this.title,
    required this.iconAsset,
    required this.child,
    this.subtitle,
    super.key,
  });

  final String title;
  final String iconAsset;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppResponsive.value(14, tablet: 18)),
      decoration: BoxDecoration(
        color: AppColors.formCard,
        borderRadius: BorderRadius.circular(
          AppResponsive.value(14, tablet: 18),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.themeColor.withValues(alpha: .06),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                iconAsset,
                width: AppResponsive.value(36, tablet: 42),
                height: AppResponsive.value(36, tablet: 42),
              ),
              Gap(AppResponsive.value(10, tablet: 12)),
              Text(title.tr, style: companyProfileSectionTitle),
            ],
          ),
          if (subtitle != null) ...<Widget>[
            Gap(AppResponsive.value(7, tablet: 9)),
            Align(
              child: Text(
                subtitle!.tr,
                textAlign: TextAlign.center,
                style: companyProfileUploadDescription,
              ),
            ),
          ],
          Gap(AppResponsive.value(16, tablet: 20)),
          child,
        ],
      ),
    );
  }
}
