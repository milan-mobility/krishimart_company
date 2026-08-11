import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/common_text_field.dart';

class CompanyProfileTextField extends StatelessWidget {
  const CompanyProfileTextField({
    required this.label,
    required this.hintText,
    required this.controller,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    super.key,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isRequired;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: label.tr,
            style: companyProfileFieldLabel,
            children: isRequired
                ? <InlineSpan>[
                    TextSpan(
                      text: ' *',
                      style: companyProfileFieldLabel.copyWith(
                        color: AppColors.roleDealer,
                      ),
                    ),
                  ]
                : null,
          ),
        ),
        Gap(AppResponsive.value(6, tablet: 8)),
        CommonTextField(
          controller: controller,
          hintText: hintText.tr,
          hintStyle: companyProfileHint,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          fillColor: AppColors.white,
          borderColor: AppColors.formBorder,
          validator: isRequired
              ? (final String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'This field is required'.tr;
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }
}
