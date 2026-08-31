import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/controllers/common_controller.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/common_appbar.dart';
import 'package:krishi_mart/view/base/common_button.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/widgets/dealer_certificate_list.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/widgets/dealer_license_date_row.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/widgets/dealer_profile_drop_down_field.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/widgets/dealer_profile_section_card.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/widgets/dealer_profile_text_field.dart';
import 'package:krishi_mart/view/screens/dealer/edit_dealer/controller/edit_dealer_profile_controller.dart';

class EditDealerProfileScreen extends StatelessWidget {
  const EditDealerProfileScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<EditDealerProfileController>(
      init: EditDealerProfileController(Get.find(), Get.find(), Get.find()),
      builder: (final EditDealerProfileController controller) {
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

                    if (controller.certificatesPath.isNotEmpty)
                      Gap(AppResponsive.value(18, tablet: 22)),
                    DealerProfileSectionCard(
                      title: 'Location Details',
                      icon: Icons.location_on_outlined,
                      trailing: SizedBox(),
                      child: Column(
                        children: <Widget>[
                          GetBuilder<CommonController>(
                            builder: (final CommonController commonController) {
                              return Column(
                                children: <Widget>[
                                  DealerProfileDropDownField(
                                    label: 'State',
                                    hintText: 'Select State',
                                    fillColor: AppColors.productSurface,
                                    items: commonController.states,
                                    value: controller.selectedState,
                                    onChanged: controller.selectState,
                                  ),
                                  Gap(AppResponsive.value(14, tablet: 18)),
                                  DealerProfileDropDownField(
                                    label: 'District',
                                    hintText: 'Select District',
                                    fillColor: AppColors.productSurface,
                                    items: commonController.districts,
                                    value: controller.selectedDistrict,
                                    onChanged: controller.selectDistrict,
                                  ),
                                  Gap(AppResponsive.value(14, tablet: 18)),
                                  DealerProfileDropDownField(
                                    label: 'Taluk',
                                    hintText: 'Select Taluk',
                                    fillColor: AppColors.productSurface,
                                    items: commonController.talukas,
                                    value: controller.selectedTaluka,
                                    onChanged: controller.selectTaluka,
                                  ),
                                  Gap(AppResponsive.value(14, tablet: 18)),
                                  DealerProfileDropDownField(
                                    label: 'Village',
                                    hintText: 'Select Village',
                                    fillColor: AppColors.productSurface,
                                    items: commonController.villages,
                                    value: controller.selectedVillage,
                                    onChanged: controller.selectVillage,
                                  ),
                                ],
                              );
                            },
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
                      title: 'License Details',
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
                          DealerLicenseDateRow(
                            issueDateController:
                                controller.txtPesticideLicenseIssueDate,
                            expireDateController:
                                controller.txtPesticideLicenseExpireDate,
                            onIssueDateSelected:
                                controller.setPesticideLicenseIssueDate,
                            onExpireDateSelected:
                                controller.setPesticideLicenseExpireDate,
                            issueDate: controller.pesticideLicenseIssueDate,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          DealerProfileTextField(
                            label: 'Fertilizer License Number',
                            hintText: 'FL-XXXX-XXXX',
                            controller: controller.txtFertilizerLicense,
                            textCapitalization: TextCapitalization.characters,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          DealerLicenseDateRow(
                            issueDateController:
                                controller.txtFertilizerLicenseIssueDate,
                            expireDateController:
                                controller.txtFertilizerLicenseExpireDate,
                            onIssueDateSelected:
                                controller.setFertilizerLicenseIssueDate,
                            onExpireDateSelected:
                                controller.setFertilizerLicenseExpireDate,
                            issueDate: controller.fertilizerLicenseIssueDate,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          DealerProfileTextField(
                            label: 'Seeds License Number',
                            hintText: 'SL-XXXX-XXXX',
                            controller: controller.txtSeedsLicense,
                            textCapitalization: TextCapitalization.characters,
                          ),
                          Gap(AppResponsive.value(14, tablet: 18)),
                          DealerLicenseDateRow(
                            issueDateController:
                                controller.txtSeedsLicenseIssueDate,
                            expireDateController:
                                controller.txtSeedsLicenseExpireDate,
                            onIssueDateSelected:
                                controller.setSeedsLicenseIssueDate,
                            onExpireDateSelected:
                                controller.setSeedsLicenseExpireDate,
                            issueDate: controller.seedsLicenseIssueDate,
                          ),
                        ],
                      ),
                    ),
                    Gap(AppResponsive.value(18, tablet: 22)),
                    InkWell(
                      onTap: controller.selectCertificates,
                      borderRadius: BorderRadius.circular(
                        AppResponsive.value(10),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: AppResponsive.value(18),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.formBorder,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(
                            AppResponsive.value(10),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.cloud_upload_outlined,
                              color: AppColors.categorySelected,
                              size: AppResponsive.value(28, tablet: 32),
                            ),
                            Gap(AppResponsive.value(4, tablet: 6)),
                            Text(
                              'PNG, JPG, PDF (Max 10MB each)'.tr,
                              style: companyProfileUploadDescription,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(AppResponsive.value(18, tablet: 22)),
                    DealerCertificateList(
                      certificatePaths: controller.certificatesPath,
                      onRemove: controller.removeCertificateAt,
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
              child: CommonButton(
                btnText: 'Submit Dealer Profile'.tr,
                borderRadius: AppResponsive.value(10),
                icon: Assets.svg.icNext,
                onPressed: controller.checkValidation,
              ),
            ),
          ),
        );
      },
    );
  }
}
