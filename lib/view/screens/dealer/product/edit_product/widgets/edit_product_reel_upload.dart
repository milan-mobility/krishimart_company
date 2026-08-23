import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/widgets/product_reel_preview.dart';
import 'package:krishi_mart/view/screens/dealer/product/edit_product/controller/edit_dealer_product_controller.dart';

class EditProductReelUpload extends StatelessWidget {
  const EditProductReelUpload({required this.controller, super.key});

  final EditDealerProductController controller;

  @override
  Widget build(final BuildContext context) {
    final bool hasPreview =
        controller.reelPreviewController?.value.isInitialized ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Product Reel'.tr,
          style: interW500.copyWith(fontSize: 14, color: AppColors.color9CA3AF),
        ),
        Gap(AppResponsive.value(6)),
        if (hasPreview) ...<Widget>[
          ProductReelPreview(
            videoController: controller.reelPreviewController!,
            onTogglePlayback: controller.toggleReelPlayback,
            onRemove: controller.removeReel,
          ),
        ] else if (controller.isLoadingExistingReel)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: AppResponsive.value(20)),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppResponsive.value(10)),
              border: Border.all(color: AppColors.productUploadBorder),
            ),
            child: const Center(child: CircularProgressIndicator()),
          )
        else if (controller.reelLoadError != null)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppResponsive.value(16)),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppResponsive.value(10)),
              border: Border.all(color: AppColors.productUploadBorder),
            ),
            child: Column(
              children: <Widget>[
                Icon(Icons.error_outline, color: AppColors.roleDealer),
                Gap(AppResponsive.value(6)),
                Text(
                  controller.reelLoadError!,
                  style: companyProfileUploadDescription,
                ),
                TextButton(
                  onPressed: controller.removeReel,
                  child: Text('Remove reel'.tr),
                ),
              ],
            ),
          )
        else
          InkWell(
            onTap: controller.isProcessingReel ? null : controller.selectReel,
            borderRadius: BorderRadius.circular(AppResponsive.value(10)),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: AppResponsive.value(20)),
              decoration: BoxDecoration(
                color: AppColors.white,
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
                      size: AppResponsive.value(24),
                    ),
                  Gap(AppResponsive.value(7)),
                  Text(
                    controller.isSelectingReel
                        ? 'Opening gallery...'.tr
                        : controller.isCompressingReel
                        ? 'Compressing reel...'.tr
                        : 'Upload Reel'.tr,
                    style: productUploadLabel,
                  ),
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
