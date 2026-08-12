import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/common_appbar.dart';
import 'package:krishi_mart/view/base/common_button.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/controller/complete_dealer_profile_controller.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/widgets/dealer_profile_drop_down_field.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/widgets/dealer_profile_progress_header.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/widgets/dealer_profile_section_card.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/widgets/dealer_profile_text_field.dart';

class CompleteDealerProfileScreen extends StatelessWidget {
  const CompleteDealerProfileScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<CompleteDealerProfileController>(
      init: CompleteDealerProfileController(Get.find(), Get.find()),
      builder: (final CompleteDealerProfileController controller) {
        return Scaffold(
          backgroundColor: AppColors.colorF7FAF7,
          appBar: CommonAppbar(
            title: 'Dealer Profile'.tr,
            backgroundColor: AppColors.white,
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          body: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                AppResponsive.value(16, tablet: 28),
                AppResponsive.value(18, tablet: 24),
                AppResponsive.value(16, tablet: 28),
                AppResponsive.value(178, tablet: 194),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: AppResponsive.contentWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const DealerProfileProgressHeader(),
                    Gap(AppResponsive.value(28, tablet: 34)),
                    Text(
                      'AgriGrow Dealer Registration'.tr,
                      style: userRoleWelcome.copyWith(
                        fontSize: AppResponsive.font(24),
                      ),
                    ),
                    Gap(AppResponsive.value(8, tablet: 10)),
                    Text(
                      'Register your agro dealership details to start trading on the KrishiMart platform'
                          .tr,
                      style: userRoleSubtitle.copyWith(
                        fontSize: AppResponsive.font(14),
                      ),
                    ),
                    Gap(AppResponsive.value(24, tablet: 30)),
                    DealerProfileSectionCard(
                      title: 'Agro Information',
                      icon: Icons.agriculture_outlined,
                      child: Column(
                        children: <Widget>[
                          DealerProfileTextField(
                            label: 'Name of Agro',
                            hintText: 'Enter firm name',
                            controller: controller.txtAgroName,
                            isRequired: true,
                            textCapitalization: TextCapitalization.words,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          DealerProfileTextField(
                            label: 'Dealer Name',
                            hintText: 'Full name of the proprietor',
                            controller: controller.txtDealerName,
                            isRequired: true,
                            textCapitalization: TextCapitalization.words,
                          ),
                        ],
                      ),
                    ),
                    Gap(AppResponsive.value(18, tablet: 22)),
                    DealerProfileSectionCard(
                      title: 'Location Details',
                      icon: Icons.location_on_outlined,
                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppResponsive.value(9),
                          vertical: AppResponsive.value(5),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.colorA4F792,
                          borderRadius: BorderRadius.circular(
                            AppResponsive.value(16),
                          ),
                        ),
                        child: Text(
                          'Auto-fill'.tr,
                          style: companyProfileCategoryTitle.copyWith(
                            color: AppColors.color1F6D1A,
                          ),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          DealerProfileDropDownField(
                            label: 'State',
                            hintText: 'Select State',
                            items: controller.states,
                            value: controller.selectedState,
                            onChanged: controller.selectState,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          DealerProfileDropDownField(
                            label: 'District',
                            hintText: 'Select District',
                            items: controller.districts,
                            value: controller.selectedDistrict,
                            onChanged: controller.selectDistrict,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          DealerProfileDropDownField(
                            label: 'Taluk',
                            hintText: 'Select Taluk',
                            items: controller.talukas,
                            value: controller.selectedTaluka,
                            onChanged: controller.selectTaluka,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          DealerProfileDropDownField(
                            label: 'Village',
                            hintText: 'Select Village',
                            items: controller.villages,
                            value: controller.selectedVillage,
                            onChanged: controller.selectVillage,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          DealerProfileTextField(
                            label: 'Detailed Address',
                            hintText: 'Shop No, Building, Street name...',
                            controller: controller.txtDetailedAddress,
                            isRequired: true,
                            maxLines: 3,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ],
                      ),
                    ),
                    Gap(AppResponsive.value(18, tablet: 22)),
                    DealerProfileSectionCard(
                      title: 'Language Preference',
                      icon: Icons.translate,
                      child: DealerProfileDropDownField(
                        label: 'Select Language',
                        hintText: 'Select Language',
                        items: controller.languages,
                        value: controller.selectedLanguage,
                        onChanged: controller.selectLanguage,
                      ),
                    ),
                    Gap(AppResponsive.value(18, tablet: 22)),
                    DealerProfileSectionCard(
                      title: 'License Details (Optional)',
                      icon: Icons.description_outlined,
                      child: Column(
                        children: <Widget>[
                          DealerProfileTextField(
                            label: 'Pesticide License Number',
                            hintText: 'PL-XXXX-XXXX',
                            controller: controller.txtPesticideLicense,
                            textCapitalization: TextCapitalization.characters,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          DealerProfileTextField(
                            label: 'Fertilizer License Number',
                            hintText: 'FL-XXXX-XXXX',
                            controller: controller.txtFertilizerLicense,
                            textCapitalization: TextCapitalization.characters,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          DealerProfileTextField(
                            label: 'Seeds License Number',
                            hintText: 'SL-XXXX-XXXX',
                            controller: controller.txtSeedsLicense,
                            textCapitalization: TextCapitalization.characters,
                          ),
                        ],
                      ),
                    ),
                    Gap(AppResponsive.value(18, tablet: 22)),
                    DealerProfileSectionCard(
                      title: 'Referral Information (Optional)',
                      icon: Icons.group_add_outlined,
                      child: Column(
                        children: <Widget>[
                          DealerProfileTextField(
                            label: 'Referral Person Name',
                            hintText: 'Name',
                            controller: controller.txtReferralName,
                            textCapitalization: TextCapitalization.words,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          DealerProfileTextField(
                            label: 'Referral Mobile Number',
                            hintText: '+91 XXXXX XXXXX',
                            controller: controller.txtReferralMobile,
                            keyboardType: TextInputType.phone,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                AppResponsive.value(16, tablet: 28),
                AppResponsive.value(10, tablet: 14),
                AppResponsive.value(16, tablet: 28),
                AppResponsive.value(12, tablet: 16),
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColors.themeColor.withValues(alpha: .08),
                    blurRadius: 12,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CommonButton(
                    btnText: 'Save as Draft'.tr,
                    btnBgColor: AppColors.white,
                    btnTxtColor: AppColors.color1F6D1A,
                    side: const BorderSide(color: AppColors.color1F6D1A),
                    borderRadius: AppResponsive.value(10),
                    onPressed: controller.saveDraft,
                  ),
                  Gap(AppResponsive.value(10, tablet: 12)),
                  CommonButton(
                    btnText: 'Submit Dealer Profile'.tr,
                    borderRadius: AppResponsive.value(10),
                    icon: Assets.svg.icNext,
                    onPressed: controller.checkValidation,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
