import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/profile_language_option.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class ProfileLanguageOptionRow extends StatelessWidget {
  const ProfileLanguageOptionRow({
    required this.language,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final ProfileLanguageOption language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppResponsive.value(12)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.value(16),
            vertical: AppResponsive.value(14),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(language.labelKey.tr, style: profileMenuLabel),
              ),
              Icon(
                isSelected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                color: isSelected
                    ? AppColors.themeColor
                    : AppColors.color717973,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
