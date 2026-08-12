import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/profile_menu_item.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class ProfileMenuRow extends StatelessWidget {
  const ProfileMenuRow({required this.item, required this.onTap, super.key});

  final ProfileMenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    final Color itemColor = item.isDestructive
        ? AppColors.roleDealer
        : AppColors.themeColor;

    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppResponsive.value(14)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.value(16, tablet: 20),
            vertical: AppResponsive.value(16, tablet: 18),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: AppResponsive.value(40),
                height: AppResponsive.value(40),
                decoration: BoxDecoration(
                  color: item.isDestructive
                      ? AppColors.productDeleteBackground
                      : AppColors.colorE8F3EC,
                  borderRadius: BorderRadius.circular(AppResponsive.value(12)),
                ),
                child: Icon(item.icon, color: itemColor),
              ),
              SizedBox(width: AppResponsive.value(14)),
              Expanded(
                child: Text(
                  item.labelKey.tr,
                  style: item.isDestructive
                      ? profileDestructiveMenuLabel
                      : profileMenuLabel,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppResponsive.value(16),
                color: item.isDestructive
                    ? AppColors.roleDealer
                    : AppColors.color717973,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
