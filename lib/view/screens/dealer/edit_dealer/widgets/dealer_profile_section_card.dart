import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class DealerProfileSectionCard extends StatelessWidget {
  const DealerProfileSectionCard({
    required this.title,
    required this.icon,
    required this.child,
    this.trailing = const SizedBox.shrink(),
    super.key,
  });

  final String title;
  final IconData icon;
  final Widget child;
  final Widget trailing;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppResponsive.value(18, tablet: 22)),
      decoration: BoxDecoration(
        color: AppColors.formCard,
        border: Border.all(color: AppColors.colorB1F0CE),
        borderRadius: BorderRadius.circular(
          AppResponsive.value(12, tablet: 16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: AppColors.color1F6D1A),
              Gap(AppResponsive.value(9, tablet: 12)),
              Expanded(
                child: Text(title.tr, style: companyProfileSectionTitle),
              ),
              trailing,
            ],
          ),
          Gap(AppResponsive.value(16, tablet: 20)),
          child,
        ],
      ),
    );
  }
}
