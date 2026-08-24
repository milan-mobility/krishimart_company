import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/bottom_navigation_bar.dart';
import 'package:krishi_mart/view/screens/profile/controller/profile_controller.dart';
import 'package:krishi_mart/view/screens/profile/widgets/profile_header_widget.dart';
import 'package:krishi_mart/view/screens/profile/widgets/profile_menu_list_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.productSurface,
        bottomNavigationBar: const BottomNavigation(selectedIndex: 2),
        body: GetBuilder<ProfileController>(
          init: ProfileController(Get.find(), Get.find()),
          builder: (final ProfileController controller) {
            return SafeArea(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: AppResponsive.contentWidth,
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppResponsive.value(18, tablet: 28)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('My Profile'.tr, style: profileTitle),
                      SizedBox(height: AppResponsive.value(20, tablet: 26)),
                      ProfileHeaderWidget(
                        name: controller.displayName,
                        businessType: controller.businessType,
                      ),
                      SizedBox(height: AppResponsive.value(22, tablet: 28)),
                      ProfileMenuListWidget(
                        items: controller.menuItems,
                        onItemTap: controller.onMenuItemTap,
                        languages: controller.languageOptions,
                        selectedLanguageCode: controller.selectedLanguageCode,
                        onLanguageSelected: controller.changeLanguage,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
