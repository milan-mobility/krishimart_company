import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/controller/add_product_controller.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/widgets/product_reel_preview.dart';

class ProductReelUpload extends StatelessWidget {
  const ProductReelUpload({required this.controller, super.key});

  final AddProductController controller;

  @override
  Widget build(final BuildContext context) {
    final videoController = controller.reelPreviewController;
    final bool hasPreview = videoController?.value.isInitialized ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Product Reel'.tr,
          style: interW500.copyWith(fontSize: 14, color: AppColors.color9CA3AF),
        ),
        Gap(AppResponsive.value(6, tablet: 8)),
        if (hasPreview)
          ProductReelPreview(
            videoController: videoController!,
            onTogglePlayback: controller.toggleReelPlayback,
            onRemove: controller.removeReel,
          )
        else
          InkWell(
            onTap: controller.isProcessingReel ? null : controller.selectReel,
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
                  if (controller.isProcessingReel)
                    SizedBox(
                      width: AppResponsive.value(24),
                      height: AppResponsive.value(24),
                      child: const CircularProgressIndicator(
                        color: AppColors.themeColor,
                        strokeWidth: 2,
                      ),
                    )
                  else
                    Icon(
                      Icons.video_library_outlined,
                      color: AppColors.color404943,
                      size: AppResponsive.value(24, tablet: 28),
                    ),
                  Gap(AppResponsive.value(7, tablet: 9)),
                  Text(
                    controller.isSelectingReel
                        ? 'Opening gallery...'.tr
                        : controller.isCompressingReel
                        ? 'Compressing reel...'.tr
                        : 'Upload Reel'.tr,
                    style: productUploadLabel,
                  ),
                  Gap(AppResponsive.value(3, tablet: 5)),
                  Text(
                    'Video up to 30 seconds'.tr,
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
