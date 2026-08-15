import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/controller/complete_company_profile_controller.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/widgets/company_profile_section_card.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/widgets/company_profile_text_field.dart';

class CompanyLicenseCertificatesSection extends StatelessWidget {
  const CompanyLicenseCertificatesSection({
    required this.controller,
    super.key,
  });

  final CompleteCompanyProfileController controller;

  @override
  Widget build(final BuildContext context) {
    return CompanyProfileSectionCard(
      title: 'License Certificates',
      iconAsset: Assets.png.icLicenceForm.path,
      subtitle: 'Upload your valid license and registration certificates',
      child: Column(
        children: <Widget>[
          CompanyProfileTextField(
            label: 'License Number',
            hintText: 'Enter license number',
            controller: controller.txtLicenseNumber,
            isRequired: true,
            textCapitalization: TextCapitalization.characters,
          ),
          Gap(AppResponsive.value(14, tablet: 18)),
          CompanyProfileTextField(
            label: 'License Issue Date',
            hintText: 'Select issue date',
            controller: controller.txtLicenseIssueDate,
            isRequired: true,
            readOnly: true,
            onTap: () => _selectIssueDate(context),
            suffixIcon: const Icon(Icons.calendar_today_outlined),
          ),
          Gap(AppResponsive.value(14, tablet: 18)),
          CompanyProfileTextField(
            label: 'License Expire Date',
            hintText: 'Select expire date',
            controller: controller.txtLicenseExpireDate,
            isRequired: true,
            readOnly: true,
            onTap: () => _selectExpireDate(context),
            suffixIcon: const Icon(Icons.calendar_today_outlined),
          ),
          Gap(AppResponsive.value(14, tablet: 18)),
          InkWell(
            onTap: controller.selectCertificates,
            borderRadius: BorderRadius.circular(AppResponsive.value(10)),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: AppResponsive.value(18)),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.formBorder,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(AppResponsive.value(10)),
              ),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: AppColors.categorySelected,
                    size: AppResponsive.value(28, tablet: 32),
                  ),
                  Gap(AppResponsive.value(7, tablet: 9)),
                  Text(
                    controller.certificatePaths.isEmpty
                        ? 'Upload Certificates'.tr
                        : '${controller.certificatePaths.length} ${'Certificates selected'.tr}',
                    style: companyProfileUploadTitle,
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
          Gap(AppResponsive.value(11, tablet: 14)),
          Row(
            children: <Widget>[
              SvgPicture.asset(Assets.svg.icCheck),
              Gap(AppResponsive.value(7, tablet: 9)),
              Expanded(
                child: Text(
                  'You can upload multiple certificates'.tr,
                  style: companyProfileUploadDescription,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectIssueDate(final BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (selectedDate != null) {
      controller.setLicenseIssueDate(selectedDate);
    }
  }

  Future<void> _selectExpireDate(final BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: today,
      lastDate: DateTime(today.year + 100),
      initialDate: today,
    );
    if (selectedDate != null) {
      controller.setLicenseExpireDate(selectedDate);
    }
  }
}
