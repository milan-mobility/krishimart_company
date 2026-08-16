import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/common_appbar.dart';
import 'package:krishi_mart/view/base/common_button.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/widgets/company_profile_text_field.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/widgets/product_dropdown_field.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/widgets/product_form_card.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/widgets/product_photo_upload.dart';
import 'package:krishi_mart/view/screens/dealer/product/add_product/controller/add_dealer_product_controller.dart';
import 'package:krishi_mart/view/screens/dealer/product/add_product/widgets/product_dealer_reel_upload.dart';

class AddDealerProductScreen extends StatelessWidget {
  const AddDealerProductScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<AddDealerProductController>(
      init: AddDealerProductController(Get.find()),
      builder: (final AddDealerProductController controller) {
        return Scaffold(
          backgroundColor: AppColors.productSurface,
          appBar: CommonAppbar(
            title: 'Add Product'.tr,
            backgroundColor: AppColors.themeColor,
            txtColor: AppColors.white,
            leadingIconColor: AppColors.white,
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Gap(AppResponsive.value(10, tablet: 12, largeTablet: 15)),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.roleCompany, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => controller.selectedTab(0),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: controller.selectedProductTab == 0
                                  ? AppColors.themeColor
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Add Product'.tr,
                                style: interW500.copyWith(
                                  fontSize: 16,
                                  color: controller.selectedProductTab == 0
                                      ? AppColors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: InkWell(
                          onTap: () => controller.selectedTab(1),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: controller.selectedProductTab != 0
                                  ? AppColors.themeColor
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Demo Product'.tr,
                                style: interW500.copyWith(
                                  fontSize: 16,
                                  color: controller.selectedProductTab != 0
                                      ? AppColors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(AppResponsive.value(10, tablet: 12, largeTablet: 15)),
                Expanded(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: AppResponsive.contentWidth,
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: <Widget>[
                            ProductFormCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Add Product'.tr,
                                    style: productFormTitle,
                                  ),
                                  Gap(AppResponsive.value(20, tablet: 24)),
                                  CompanyProfileTextField(
                                    label: 'Product Name',
                                    hintText: 'e.g. Ampigo 150 ZC',
                                    controller: controller.txtProductName,
                                    textStyle: interW500.copyWith(
                                      fontSize: 14,
                                      color: AppColors.color9CA3AF,
                                    ),
                                    isRequired: true,
                                  ),
                                  Gap(AppResponsive.value(14, tablet: 18)),
                                  CompanyProfileTextField(
                                    label: 'Company',
                                    hintText: 'e.g. Syngenta',
                                    controller: controller.txtCompany,
                                    textStyle: interW500.copyWith(
                                      fontSize: 14,
                                      color: AppColors.color9CA3AF,
                                    ),
                                    isRequired: true,
                                  ),
                                  if (controller.selectedProductTab == 1) ...[
                                    Gap(AppResponsive.value(14, tablet: 18)),
                                    CompanyProfileTextField(
                                      label: 'Farmer Name',
                                      hintText: 'Enter farmer name',
                                      controller: controller.txtFarmerName,
                                      textStyle: interW500.copyWith(
                                        fontSize: 14,
                                        color: AppColors.color9CA3AF,
                                      ),
                                      isRequired: true,
                                    ),
                                  ],
                                  Gap(AppResponsive.value(14, tablet: 18)),
                                  ProductDropdownField(
                                    label: 'Category',
                                    hintText: 'Select category',
                                    items:
                                        controller.commonController.categories,
                                    selectedItem: controller.selectedCategory,
                                    itemAsString: (final item) =>
                                        item.name ?? '',
                                    onChanged: controller.selectCategory,
                                  ),
                                  Gap(AppResponsive.value(14, tablet: 18)),
                                  CompanyProfileTextField(
                                    label: 'Description',
                                    hintText: 'Product details...',
                                    controller: controller.txtDescription,
                                    textStyle: interW500.copyWith(
                                      fontSize: 14,
                                      color: AppColors.color9CA3AF,
                                    ),
                                    maxLines: 3,
                                    isRequired: true,
                                  ),
                                  Gap(AppResponsive.value(14, tablet: 18)),
                                  CompanyProfileTextField(
                                    label: 'Dose',
                                    hintText: 'e.g. 80ml/acre',
                                    controller: controller.txtDose,
                                    textStyle: interW500.copyWith(
                                      fontSize: 14,
                                      color: AppColors.color9CA3AF,
                                    ),
                                    isRequired: true,
                                  ),
                                  Gap(AppResponsive.value(14, tablet: 18)),
                                  ProductDropdownField(
                                    label: 'Crops',
                                    hintText: 'Select crop',
                                    items: controller.commonController.crops,
                                    selectedItem: controller.selectedCrop,
                                    itemAsString: (final item) =>
                                        item.name ?? '',
                                    onChanged: controller.selectCrop,
                                  ),
                                  Gap(AppResponsive.value(14, tablet: 18)),
                                  ProductPhotoUpload(
                                    onPhotoSelect: () {
                                      controller.selectPhotos();
                                    },
                                  ),
                                  Gap(AppResponsive.value(14, tablet: 18)),
                                  CompanyProfileTextField(
                                    label: 'YouTube Video Link',
                                    hintText: 'https://youtube.com/...',
                                    controller: controller.txtYoutubeLink,
                                    keyboardType: TextInputType.url,
                                    textStyle: interW500.copyWith(
                                      fontSize: 14,
                                      color: AppColors.color9CA3AF,
                                    ),
                                  ),
                                  Gap(AppResponsive.value(14, tablet: 18)),
                                  ProductDealerReelUpload(
                                    controller: controller,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(
              bottom: AppResponsive.value(16, tablet: 28),
            ),
            padding: EdgeInsets.fromLTRB(
              AppResponsive.value(16, tablet: 28),
              AppResponsive.value(12, tablet: 16),
              AppResponsive.value(16, tablet: 28),
              AppResponsive.value(12, tablet: 16),
            ),

            child: CommonButton(
              btnText: 'Save Product'.tr,
              borderRadius: AppResponsive.value(10),
              onPressed: controller.saveProduct,
            ),
          ),
        );
      },
    );
  }
}
