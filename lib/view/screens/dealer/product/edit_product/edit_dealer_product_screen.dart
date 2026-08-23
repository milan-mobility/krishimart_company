import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/view/base/common_appbar.dart';
import 'package:krishi_mart/view/base/common_button.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/widgets/company_profile_text_field.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/widgets/product_dropdown_field.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/widgets/product_form_card.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/widgets/product_photo_upload.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/widgets/dealer_profile_drop_down_field.dart';
import 'package:krishi_mart/view/screens/dealer/product/add_product/widgets/dealer_product_crop_selector.dart';
import 'package:krishi_mart/view/screens/dealer/product/add_product/widgets/dealer_product_image_grid.dart';
import 'package:krishi_mart/view/screens/dealer/product/edit_product/controller/edit_dealer_product_controller.dart';
import 'package:krishi_mart/view/screens/dealer/product/edit_product/widgets/existing_product_image_grid.dart';
import 'package:krishi_mart/view/screens/dealer/product/edit_product/widgets/edit_product_reel_upload.dart';

class EditDealerProductScreen extends StatelessWidget {
  const EditDealerProductScreen({
    required this.product,
    this.updateEndpoint,
    super.key,
  });
  final Product product;
  final String? updateEndpoint;

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<EditDealerProductController>(
      init: EditDealerProductController(
        Get.find(),
        Get.find(),
        product,
        updateEndpoint,
      ),
      builder: (final EditDealerProductController controller) => Scaffold(
        backgroundColor: AppColors.productSurface,
        appBar: CommonAppbar(
          title: 'Edit Product'.tr,
          backgroundColor: AppColors.themeColor,
          txtColor: AppColors.white,
          leadingIconColor: AppColors.white,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(AppResponsive.value(16, tablet: 28)),
          child: Form(
            key: controller.formKey,
            child: ProductFormCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CompanyProfileTextField(
                    label: 'Product Name',
                    hintText: 'e.g. Ampigo 150 ZC',
                    controller: controller.txtProductName,
                    isRequired: true,
                  ),
                  Gap(AppResponsive.value(14)),
                  CompanyProfileTextField(
                    label: 'Company',
                    hintText: 'e.g. Syngenta',
                    controller: controller.txtCompany,
                    isRequired: true,
                  ),
                  if (controller.isDemoProduct) ...<Widget>[
                    Gap(AppResponsive.value(14)),
                    CompanyProfileTextField(
                      label: 'Farmer Name',
                      hintText: 'Enter farmer name',
                      controller: controller.txtFarmerName,
                      isRequired: true,
                    ),
                    Gap(AppResponsive.value(14)),
                    DealerProfileDropDownField(
                      label: 'Taluk',
                      hintText: 'Select Taluk',
                      items: controller.commonController.talukas,
                      value: controller.selectedTaluka,
                      onChanged: controller.selectTaluka,
                    ),
                    Gap(AppResponsive.value(14)),
                    DealerProfileDropDownField(
                      label: 'Village',
                      hintText: 'Select Village',
                      items: controller.commonController.villages,
                      value: controller.selectedVillage,
                      onChanged: controller.selectVillage,
                    ),
                  ],
                  Gap(AppResponsive.value(14)),
                  ProductDropdownField(
                    label: 'Category',
                    hintText: 'Select category',
                    items: controller.commonController.categories,
                    selectedItem: controller.selectedCategory,
                    itemAsString: (final item) => item.name ?? '',
                    onChanged: controller.selectCategory,
                  ),
                  Gap(AppResponsive.value(14)),
                  CompanyProfileTextField(
                    label: 'Description',
                    hintText: 'Product details...',
                    controller: controller.txtDescription,
                    maxLines: 3,
                    isRequired: true,
                  ),
                  Gap(AppResponsive.value(14)),
                  CompanyProfileTextField(
                    label: 'Dose',
                    hintText: 'e.g. 80ml/acre',
                    controller: controller.txtDose,
                    isRequired: true,
                  ),
                  Gap(AppResponsive.value(14)),
                  DealerProductCropSelector(
                    crops: controller.commonController.crops,
                    selectedCrops: controller.selectedCrops,
                    onChanged: controller.selectCrops,
                  ),
                  Gap(AppResponsive.value(14)),
                  ProductPhotoUpload(onPhotoSelect: controller.selectPhotos),
                  if (controller.existingImageUrls.isNotEmpty) ...<Widget>[
                    Gap(AppResponsive.value(14)),
                    ExistingProductImageGrid(
                      imageUrls: controller.existingImageUrls,
                      onRemove: controller.removeExistingPhotoAt,
                    ),
                  ],
                  if (controller.photoPaths.isNotEmpty) ...<Widget>[
                    Gap(AppResponsive.value(14)),
                    DealerProductImageGrid(
                      imagePaths: controller.photoPaths,
                      onRemove: controller.removePhotoAt,
                    ),
                  ],
                  Gap(AppResponsive.value(14)),
                  CompanyProfileTextField(
                    label: 'YouTube Video Link',
                    hintText: 'https://youtube.com/...',
                    controller: controller.txtYoutubeLink,
                    keyboardType: TextInputType.url,
                  ),
                  Gap(AppResponsive.value(14)),
                  EditProductReelUpload(controller: controller),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppResponsive.value(16)),
            child: CommonButton(
              btnText: 'Save Product'.tr,
              onPressed: controller.updateProduct,
            ),
          ),
        ),
      ),
    );
  }
}
