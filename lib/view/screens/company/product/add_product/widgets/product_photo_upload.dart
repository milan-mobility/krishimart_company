import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/controller/add_product_controller.dart';

class ProductPhotoUpload extends StatelessWidget {
  const ProductPhotoUpload({required this.controller, super.key});

  final AddProductController controller;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Photos'.tr,
          style: interW500.copyWith(fontSize: 14, color: AppColors.color9CA3AF),
        ),
        Gap(AppResponsive.value(6, tablet: 8)),
        InkWell(
          onTap: controller.selectPhotos,
          borderRadius: BorderRadius.circular(AppResponsive.value(10)),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: AppResponsive.value(20)),
            decoration: BoxDecoration(
              color: AppColors.productSurface,
              borderRadius: BorderRadius.circular(AppResponsive.value(10)),
              border: Border.all(color: AppColors.productUploadBorder),
            ),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.add_a_photo_outlined,
                  color: AppColors.color404943,
                  size: AppResponsive.value(24, tablet: 28),
                ),
                Gap(AppResponsive.value(7, tablet: 9)),
                Text(
                  controller.photoPaths.isEmpty
                      ? 'Upload Photos'.tr
                      : '${controller.photoPaths.length} ${'Photos selected'.tr}',
                  style: productUploadLabel,
                ),
                Gap(AppResponsive.value(3, tablet: 5)),
                Text(
                  'JPG, PNG up to 5MB'.tr,
                  style: companyProfileUploadDescription,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
