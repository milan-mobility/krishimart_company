import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/common_appbar.dart';
import 'package:krishi_mart/view/base/common_button.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/controller/add_product_controller.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/widgets/product_form_card.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/widgets/product_photo_upload.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/widgets/product_reel_upload.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/widgets/product_text_field.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<AddProductController>(
      builder: (final AddProductController controller) {
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
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                AppResponsive.value(16, tablet: 28),
                AppResponsive.value(16, tablet: 28),
                AppResponsive.value(16, tablet: 28),
                AppResponsive.value(98, tablet: 116),
              ),
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
                            Text('Add Product'.tr, style: productFormTitle),
                            Gap(AppResponsive.value(20, tablet: 24)),
                            ProductTextField(
                              label: 'Product Name',
                              hintText: 'e.g. Ampigo 150 ZC',
                              controller: controller.txtProductName,
                            ),
                            Gap(AppResponsive.value(14, tablet: 18)),
                            ProductTextField(
                              label: 'Company',
                              hintText: 'e.g. Syngenta',
                              controller: controller.txtCompany,
                            ),
                            Gap(AppResponsive.value(14, tablet: 18)),
                            ProductTextField(
                              label: 'Category',
                              hintText: 'e.g. Pesticide',
                              controller: controller.txtCategory,
                            ),
                            Gap(AppResponsive.value(14, tablet: 18)),
                            ProductTextField(
                              label: 'Description',
                              hintText: 'Product details...',
                              controller: controller.txtDescription,
                              maxLines: 3,
                            ),
                            Gap(AppResponsive.value(14, tablet: 18)),
                            ProductTextField(
                              label: 'Dose',
                              hintText: 'e.g. 80ml/acre',
                              controller: controller.txtDose,
                            ),
                            Gap(AppResponsive.value(14, tablet: 18)),
                            ProductTextField(
                              label: 'Crops',
                              hintText: 'e.g. Cotton, Chilli',
                              controller: controller.txtCrops,
                            ),
                            Gap(AppResponsive.value(14, tablet: 18)),
                            ProductPhotoUpload(controller: controller),
                            Gap(AppResponsive.value(14, tablet: 18)),
                            ProductTextField(
                              label: 'YouTube Video Link',
                              hintText: 'https://youtube.com/...',
                              controller: controller.txtYoutubeLink,
                              keyboardType: TextInputType.url,
                            ),
                            Gap(AppResponsive.value(14, tablet: 18)),
                            ProductReelUpload(controller: controller),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
