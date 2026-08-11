import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/utils/app_enums.dart';
import 'package:krishi_mart/view/screens/user_role/controller/user_role_controller.dart';
import 'package:krishi_mart/view/screens/user_role/widgets/role_background_widget.dart';
import 'package:krishi_mart/view/screens/user_role/widgets/role_benefits_section.dart';
import 'package:krishi_mart/view/screens/user_role/widgets/role_option_card.dart';
import 'package:krishi_mart/view/screens/user_role/widgets/role_selection_header_widget.dart';

class UserRoleScreen extends StatelessWidget {
  const UserRoleScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.roleBackground,
        body: SafeArea(
          bottom: false,
          child: GetBuilder<UserRoleController>(
            init: UserRoleController(Get.find()),
            builder: (final UserRoleController controller) {
              return Container(
                width: Get.width,
                height: Get.height,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.white,
                      AppColors.colorF7FAF7,
                      AppColors.colorE8F5E9,
                    ],
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    const RoleBackgroundWidget(),
                    Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: AppResponsive.contentWidth,
                        ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(
                            AppResponsive.value(24, tablet: 40),
                            AppResponsive.value(24, tablet: 34),
                            AppResponsive.value(24, tablet: 40),
                            AppResponsive.value(20, tablet: 30),
                          ),
                          child: Column(
                            children: <Widget>[
                              const RoleSelectionHeaderWidget(),
                              Gap(AppResponsive.value(34, tablet: 44)),
                              RoleOptionCard(
                                title: 'Company',
                                description:
                                    'I am a company and want to showcase my products',
                                iconAsset: Assets.png.icCompany.path,
                                color: AppColors.roleCompany,
                                iconBackgroundColor:
                                    AppColors.roleCompanyIconBackground,
                                onTap: () =>
                                    controller.selectRole(UserType.company),
                              ),
                              Gap(AppResponsive.value(22, tablet: 28)),
                              RoleOptionCard(
                                title: 'Dealer',
                                description:
                                    'I am a dealer and want to sell products',
                                iconAsset: Assets.png.icDealer.path,
                                color: AppColors.roleDealer,
                                iconBackgroundColor:
                                    AppColors.roleDealerIconBackground,
                                onTap: () =>
                                    controller.selectRole(UserType.dealer),
                              ),
                              Gap(AppResponsive.value(44, tablet: 56)),
                              const RoleBenefitsSection(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
