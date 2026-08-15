import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/profile_language_option.dart';
import 'package:krishi_mart/data/model/profile_menu_item.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/view/screens/profile/widgets/profile_menu_row.dart';
import 'package:krishi_mart/view/screens/profile/widgets/profile_language_selection_sheet.dart';

class ProfileMenuListWidget extends StatelessWidget {
  const ProfileMenuListWidget({
    required this.items,
    required this.onItemTap,
    required this.languages,
    required this.selectedLanguageCode,
    required this.onLanguageSelected,
    super.key,
  });

  final List<ProfileMenuItem> items;
  final ValueChanged<ProfileMenuItem> onItemTap;
  final List<ProfileLanguageOption> languages;
  final String selectedLanguageCode;
  final ValueChanged<String> onLanguageSelected;

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppResponsive.value(18)),
        border: Border.all(color: AppColors.formBorder),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (final BuildContext context, final int index) =>
            const Divider(height: 1, indent: 70, color: AppColors.formBorder),
        itemBuilder: (final BuildContext context, final int index) {
          final ProfileMenuItem item = items[index];
          return ProfileMenuRow(
            item: item,
            onTap: item.action == ProfileMenuAction.changeLanguage
                ? _showLanguageSelection
                : () => onItemTap(item),
          );
        },
      ),
    );
  }

  void _showLanguageSelection() {
    Get.bottomSheet<void>(
      ProfileLanguageSelectionSheet(
        languages: languages,
        selectedLanguageCode: selectedLanguageCode,
        onLanguageSelected: onLanguageSelected,
      ),
      isScrollControlled: true,
    );
  }
}
