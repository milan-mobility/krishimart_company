import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/profile_language_option.dart';
import 'package:krishi_mart/data/model/profile_menu_item.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/confirmation_bottom_sheet.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';

class ProfileController extends GetxController {
  ProfileController(this._sharedPreferenceHelper);

  final SharedPreferenceHelper _sharedPreferenceHelper;

  final List<ProfileLanguageOption> languageOptions =
      const <ProfileLanguageOption>[
        ProfileLanguageOption(code: 'en', labelKey: 'English'),
        ProfileLanguageOption(code: 'gu', labelKey: 'Gujarati'),
      ];

  final List<ProfileMenuItem> menuItems = const <ProfileMenuItem>[
    ProfileMenuItem(
      labelKey: 'Change Language',
      icon: Icons.language_rounded,
      action: ProfileMenuAction.changeLanguage,
    ),
    ProfileMenuItem(
      labelKey: 'Privacy Policy',
      icon: Icons.privacy_tip_outlined,
      action: ProfileMenuAction.privacyPolicy,
    ),
    ProfileMenuItem(
      labelKey: 'Terms and Conditions',
      icon: Icons.description_outlined,
      action: ProfileMenuAction.termsAndConditions,
    ),
    ProfileMenuItem(
      labelKey: 'Help and Support',
      icon: Icons.support_agent_outlined,
      action: ProfileMenuAction.helpAndSupport,
    ),
    ProfileMenuItem(
      labelKey: 'Logout',
      icon: Icons.logout_rounded,
      action: ProfileMenuAction.logout,
      isDestructive: true,
    ),
    ProfileMenuItem(
      labelKey: 'Delete Account',
      icon: Icons.delete_outline_rounded,
      action: ProfileMenuAction.deleteAccount,
      isDestructive: true,
    ),
  ];

  String get displayName =>
      _sharedPreferenceHelper.getUserInfo?.name ?? 'KrishiMart'.tr;

  String get businessType {
    final String role =
        _sharedPreferenceHelper.getUserInfo?.role ??
        _sharedPreferenceHelper.getUserRole;
    return role.toLowerCase() == 'dealer'
        ? 'Agro Dealer'.tr
        : 'Agro Company'.tr;
  }

  String get selectedLanguageCode => _sharedPreferenceHelper.getLanguageCode;

  Future<void> changeLanguage(final String languageCode) async {
    if (languageCode == selectedLanguageCode) return;

    await _sharedPreferenceHelper.setLanguageCode(languageCode);
    await Get.updateLocale(Locale(languageCode));
    update();
  }

  Future<void> onMenuItemTap(final ProfileMenuItem item) async {
    switch (item.action) {
      case ProfileMenuAction.changeLanguage:
        return;
      case ProfileMenuAction.logout:
        Get.bottomSheet(
          ConfirmationBottomSheet(
            title: 'Logout'.tr,
            description: 'Are you sure you want to logout?'.tr,
            onPositive: () {
              Utility.logout();
            },
            txtPositive: 'Yes,Logout'.tr,
          ),
        );
        return;
      case ProfileMenuAction.deleteAccount:
        Get.bottomSheet(
          ConfirmationBottomSheet(
            title: 'Delete'.tr,
            description: 'Are you sure you want to delete your account?'.tr,
            onPositive: () {
              //Delete api call
            },
            txtPositive: 'Yes,Delte'.tr,
          ),
        );
        showErrorSnackBar(message: 'Delete account support is coming soon'.tr);
        return;
      case ProfileMenuAction.privacyPolicy:
      case ProfileMenuAction.termsAndConditions:
      case ProfileMenuAction.helpAndSupport:
        showSuccessSnackBar(message: 'This page is coming soon'.tr);
        return;
    }
  }
}
