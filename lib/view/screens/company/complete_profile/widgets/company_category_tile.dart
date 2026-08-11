import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class CompanyCategoryTile extends StatelessWidget {
  const CompanyCategoryTile({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppResponsive.value(3)),
        child: Material(
          color: isSelected ? AppColors.colorE8F5E9 : AppColors.colorF7FAF7,
          borderRadius: BorderRadius.circular(AppResponsive.value(9)),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppResponsive.value(9)),
            child: Container(
              height: AppResponsive.value(66, tablet: 76),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppResponsive.value(9)),
                border: isSelected
                    ? Border.all(color: AppColors.categorySelected, width: 1.5)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    size: AppResponsive.value(20, tablet: 24),
                    color: AppColors.themeColor,
                  ),
                  SizedBox(height: AppResponsive.value(5, tablet: 7)),
                  Text(title.tr, style: companyProfileCategoryTitle),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
