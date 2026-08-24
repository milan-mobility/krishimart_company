import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/profile_language_option.dart';
import 'package:krishi_mart/data/model/profile_menu_item.dart';
import 'package:krishi_mart/data/network/connection.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/auth_repo.dart';
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/confirmation_bottom_sheet.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/loader.dart';

class ProfileController extends GetxController {
  ProfileController(this._sharedPreferenceHelper, this._authRepo);

  final SharedPreferenceHelper _sharedPreferenceHelper;
  final AuthRepo _authRepo;

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
              deleteAccount();
            },
            txtPositive: 'Yes,Delte'.tr,
          ),
        );
        return;
      case ProfileMenuAction.privacyPolicy:
      case ProfileMenuAction.termsAndConditions:
      case ProfileMenuAction.helpAndSupport:
        showSuccessSnackBar(message: 'This page is coming soon'.tr);
        return;
    }
  }

  Future<void> deleteAccount() async {
    final bool isInternetAvailable = await ConnectionUtils.isNetworkConnected();
    if (!isInternetAvailable) {
      showErrorSnackBar(
        title: MessageConstant.netWorkTitle,
        message: MessageConstant.networkError,
      );
      return;
    }

    try {
      Loader.load(true);
      final bool isDeleted = await _authRepo.deleteAccount(<String, dynamic>{
        'confirmation': 'DELETE',
      });

      if (isDeleted) {
        Utility.logout();
      } else {
        showErrorSnackBar(message: 'Something went wrong!'.tr);
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
    } catch (e) {
      debugPrint('DELETE ACCOUNT EXCEPTION=>${e.toString()}');
      showErrorSnackBar(message: 'Something went wrong!'.tr);
    } finally {
      Loader.load(false);
    }
  }
}
