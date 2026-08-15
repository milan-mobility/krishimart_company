import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/profile_language_option.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/screens/profile/widgets/profile_language_option_row.dart';

class ProfileLanguageSelectionSheet extends StatelessWidget {
  const ProfileLanguageSelectionSheet({
    required this.languages,
    required this.selectedLanguageCode,
    required this.onLanguageSelected,
    super.key,
  });

  final List<ProfileLanguageOption> languages;
  final String selectedLanguageCode;
  final ValueChanged<String> onLanguageSelected;

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          AppResponsive.value(20),
          AppResponsive.value(12),
          AppResponsive.value(20),
          AppResponsive.value(20),
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppResponsive.value(22)),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                width: AppResponsive.value(44),
                height: AppResponsive.value(4),
                decoration: BoxDecoration(
                  color: AppColors.formBorder,
                  borderRadius: BorderRadius.circular(AppResponsive.value(8)),
                ),
              ),
            ),
            SizedBox(height: AppResponsive.value(20)),
            Text('Select Language'.tr, style: profileTitle),
            SizedBox(height: AppResponsive.value(10)),
            ...languages.map(
              (final ProfileLanguageOption language) =>
                  ProfileLanguageOptionRow(
                    language: language,
                    isSelected: language.code == selectedLanguageCode,
                    onTap: () {
                      onLanguageSelected(language.code);
                      Get.back<void>();
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
