import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/controllers/common_controller.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/view/base/common_appbar.dart';
import 'package:krishi_mart/view/base/common_button.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/controller/complete_company_profile_controller.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/widgets/company_business_category_section.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/widgets/company_license_certificates_section.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/widgets/company_profile_section_card.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/widgets/company_profile_text_field.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/widgets/dealer_profile_drop_down_field.dart';

class CompleteCompanyProfileScreen extends StatelessWidget {
  const CompleteCompanyProfileScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<CompleteCompanyProfileController>(
      init: CompleteCompanyProfileController(
        Get.find(),
        Get.find(),
        Get.find(),
      ),
      builder: (final CompleteCompanyProfileController controller) {
        return Scaffold(
          backgroundColor: AppColors.colorF7FAF7,
          appBar: CommonAppbar(
            title: 'Company Profile'.tr,
            subtitle: 'Complete your company information'.tr,
            backgroundColor: AppColors.themeColor,
            txtColor: AppColors.white,
            subtitleColor: AppColors.white.withValues(alpha: .75),
            leadingIconColor: AppColors.white,
          ),
          body: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                AppResponsive.value(16, tablet: 28),
                AppResponsive.value(18, tablet: 24),
                AppResponsive.value(16, tablet: 28),
                AppResponsive.value(110, tablet: 130),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: AppResponsive.contentWidth,
                ),
                child: Column(
                  children: <Widget>[
                    CompanyProfileSectionCard(
                      title: 'Basic Information',
                      iconAsset: Assets.png.icBasicForm.path,
                      child: Column(
                        children: <Widget>[
                          CompanyProfileTextField(
                            label: 'Company Name',
                            hintText: 'Enter company name',
                            controller: controller.txtCompanyName,
                            isRequired: true,
                            textCapitalization: TextCapitalization.words,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          CompanyProfileTextField(
                            label: 'GST Number',
                            hintText: 'Enter GST number',
                            controller: controller.txtGstNumber,
                            isRequired: true,
                            maxLength: 15,
                            textCapitalization: TextCapitalization.characters,
                            additionalValidator: (final String? value) {
                              final String gstin =
                                  value?.trim().toUpperCase() ?? '';
                              final RegExp gstinPattern = RegExp(
                                r'^\d{2}[A-Z]{5}\d{4}[A-Z][1-9A-Z]Z[0-9A-Z]$',
                              );

                              if (!gstinPattern.hasMatch(gstin)) {
                                return 'Enter a valid GSTIN'.tr;
                              }
                              return null;
                            },
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          CompanyProfileTextField(
                            label: 'CIN Number',
                            hintText: 'Enter CIN number',
                            controller: controller.txtCinNumber,
                            isRequired: true,
                            textCapitalization: TextCapitalization.characters,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          CompanyProfileTextField(
                            label: 'PAN Number',
                            hintText: 'Enter PAN number',
                            controller: controller.txtPanNumber,
                            isRequired: true,
                            textCapitalization: TextCapitalization.characters,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          CompanyProfileTextField(
                            label: 'TAN Number',
                            hintText: 'Enter TAN number (Optional)',
                            controller: controller.txtTanNumber,
                            textCapitalization: TextCapitalization.characters,
                          ),
                        ],
                      ),
                    ),
                    Gap(AppResponsive.value(20, tablet: 24)),
                    CompanyBusinessCategorySection(controller: controller),
                    Gap(AppResponsive.value(20, tablet: 24)),
                    CompanyProfileSectionCard(
                      title: 'Company Address',
                      iconAsset: Assets.png.icCompanyForm.path,
                      child: Column(
                        children: <Widget>[
                          CompanyProfileTextField(
                            label: 'Address Line 1',
                            hintText: 'Enter address line 1',
                            controller: controller.txtAddressLine1,
                            isRequired: true,
                            textCapitalization: TextCapitalization.words,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          CompanyProfileTextField(
                            label: 'Address Line 2 (Optional)',
                            hintText: 'Enter address line 2',
                            controller: controller.txtAddressLine2,
                            textCapitalization: TextCapitalization.words,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          GetBuilder<CommonController>(
                            builder: (final CommonController commonController) {
                              return Row(
                                children: <Widget>[
                                  Expanded(
                                    child: DealerProfileDropDownField(
                                      label: 'State',
                                      hintText: 'Select State',
                                      items: commonController.states,
                                      value: controller.selectedState,
                                      onChanged: controller.selectState,
                                    ),
                                  ),
                                  Gap(AppResponsive.value(14, tablet: 18)),
                                  Expanded(
                                    child: DealerProfileDropDownField(
                                      label: 'District',
                                      hintText: 'Select District',
                                      items: commonController.districts,
                                      value: controller.selectedDistrict,
                                      onChanged: controller.selectDistrict,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          CompanyProfileTextField(
                            label: 'Pincode',
                            hintText: 'Enter pincode',
                            maxLength: 6,
                            minLength: 6,
                            minLengthErrorText: 'Pincode must be 6 digits',
                            controller: controller.txtPincode,
                            isRequired: true,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    Gap(AppResponsive.value(20, tablet: 24)),
                    CompanyLicenseCertificatesSection(controller: controller),
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
                AppResponsive.value(12, tablet: 16),
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
              child: CommonButton(
                btnText: 'Save & Continue'.tr,
                icon: Assets.svg.icNext,
                borderRadius: AppResponsive.value(12, tablet: 14),
                onPressed: controller.checkValidation,
              ),
            ),
          ),
        );
      },
    );
  }
}
