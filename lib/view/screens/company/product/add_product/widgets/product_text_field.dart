import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/common_text_field.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({
    required this.label,
    required this.hintText,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType keyboardType;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label.tr,
          style: interW500.copyWith(fontSize: 14, color: AppColors.color9CA3AF),
        ),
        Gap(AppResponsive.value(6, tablet: 8)),
        CommonTextField(
          controller: controller,
          hintText: hintText.tr,
          hintStyle: companyProfileHint,
          maxLines: maxLines,
          keyboardType: keyboardType,
          fillColor: AppColors.productSurface,
          borderColor: AppColors.productUploadBorder,
          validator: (final String? value) {
            if (value?.trim().isEmpty ?? true) {
              return 'This field is required'.tr;
            }
            return null;
          },
        ),
      ],
    );
  }
}
