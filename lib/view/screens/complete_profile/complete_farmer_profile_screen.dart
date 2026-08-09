import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/id_name_model.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/extensions/list_extension.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/utils/app_enums.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/common_button.dart';
import 'package:krishi_mart/view/base/common_drop_down_field.dart';
import 'package:krishi_mart/view/base/common_text_field.dart';
import 'package:krishi_mart/view/screens/complete_profile/controller/complete_farmer_profile_controller.dart';

class CompleteFarmerProfileScreen extends StatelessWidget {
  const CompleteFarmerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<CompleteFarmerProfileController>(
        init: CompleteFarmerProfileController(Get.find(), Get.find()),
        builder: (final CompleteFarmerProfileController controller) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(AppResponsive.value(30, tablet: 45)),
                          Text(
                            'Complete Your Profile'.tr,
                            style: interW700.copyWith(
                              fontSize: 25,
                              color: AppColors.themeColor,
                            ),
                          ),
                          Gap(AppResponsive.value(24, tablet: 32)),
                          Align(
                            alignment: Alignment.center,
                            child: _buildProfilePicture(controller.imagePath, (
                              photo,
                            ) {
                              controller.setProfilePic(photo);
                            }),
                          ),
                          Gap(AppResponsive.value(10, tablet: 15)),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Upload profile photo'.tr,
                              style: interW600.copyWith(
                                color: AppColors.color414844,
                              ),
                            ),
                          ),
                          Gap(AppResponsive.value(30, tablet: 45)),
                          Text(
                            'Full Name'.tr,
                            style: interW600.copyWith(
                              color: AppColors.color191C1C,
                            ),
                          ),
                          Gap(AppResponsive.value(10, tablet: 15)),
                          CommonTextField(
                            controller: controller.txtName,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.done,
                            prefixIcon: SvgPicture.asset(Assets.svg.icGuest),
                            validator: (final String? value) {
                              final phone = value?.trim() ?? '';

                              if (phone.isEmpty) {
                                return 'Please enter your name'.tr;
                              }
                              return null;
                            },
                          ),
                          Gap(AppResponsive.value(10, tablet: 15)),
                          Text(
                            'State'.tr,
                            style: interW600.copyWith(
                              color: AppColors.color191C1C,
                            ),
                          ),
                          Gap(AppResponsive.value(10, tablet: 15)),
                          CommonDropDownField<IdName>(
                            list: controller.districts,
                            selectedItem: controller.selectedDistrict,
                            onItemChange: (final IdName? item) {
                              controller.selectDistrict(item);
                            },
                            itemAsString: (final IdName? item) =>
                                item?.name ?? '',
                          ),
                          Gap(AppResponsive.value(10, tablet: 15)),
                          Text(
                            'District'.tr,
                            style: interW600.copyWith(
                              color: AppColors.color191C1C,
                            ),
                          ),
                          Gap(AppResponsive.value(10, tablet: 15)),
                          CommonDropDownField<IdName>(
                            list: controller.districts,
                            selectedItem: controller.selectedDistrict,
                            onItemChange: (final IdName? item) {
                              controller.selectDistrict(item);
                            },
                            itemAsString: (final IdName? item) =>
                                item?.name ?? '',
                          ),
                          Gap(AppResponsive.value(5, tablet: 10)),
                          Text(
                            'Taluka'.tr,
                            style: interW600.copyWith(
                              color: AppColors.color191C1C,
                            ),
                          ),
                          Gap(AppResponsive.value(10, tablet: 15)),
                          CommonDropDownField<IdName>(
                            list: controller.talukas,
                            selectedItem: controller.selectedTaluka,
                            onItemChange: (final IdName? item) {
                              controller.selectTaluka(item);
                            },
                            itemAsString: (final IdName? item) =>
                                item?.name ?? '',
                          ),
                          Gap(AppResponsive.value(10, tablet: 15)),
                          Text(
                            'Village'.tr,
                            style: interW600.copyWith(
                              color: AppColors.color191C1C,
                            ),
                          ),
                          Gap(AppResponsive.value(10, tablet: 15)),
                          CommonDropDownField<IdName>(
                            list: controller.villages,
                            selectedItem: controller.selectedVillage,
                            onItemChange: (final IdName? item) {
                              controller.selectVillage(item);
                            },
                            itemAsString: (final IdName? item) =>
                                item?.name ?? '',
                          ),

                          Gap(AppResponsive.value(10, tablet: 15)),
                          Text(
                            'Preferred Language'.tr,
                            style: interW600.copyWith(
                              color: AppColors.color191C1C,
                            ),
                          ),
                          Gap(AppResponsive.value(10, tablet: 15)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.colorBFC9C1.withValues(
                                  alpha: .5,
                                ),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.colorECEEED,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<AppLanguage>(
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                value: controller.language,
                                icon: SvgPicture.asset(Assets.svg.icArrowDown),
                                onChanged: (final AppLanguage? newValue) {
                                  if (newValue != null) {
                                    controller.setLanguage(newValue);
                                  }
                                },
                                items: (controller.languages).map((
                                  final AppLanguage value,
                                ) {
                                  return DropdownMenuItem<AppLanguage>(
                                    value: value,
                                    child: Text(
                                      value.languageName,
                                      style: interW400.copyWith(
                                        fontSize: 16,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(AppResponsive.value(24, tablet: 34)),
                CommonButton(
                  icon: Assets.svg.icNext,
                  btnText: 'Finish'.tr,
                  onPressed: () {
                    controller.checkValidation();
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
          );
        },
      ),
    );
  }

  Widget _buildProfilePicture(
    final String path,
    final Function(String) onPicTap,
  ) {
    return Stack(
      children: [
        Container(
          height: 128,
          width: 128,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.colorB1F0CE, width: 4),
          ),
          child: path.isEmpty
              ? SvgPicture.asset(Assets.svg.icUser)
              : Utility.checkIsNetworkUrl(path)
              ? CachedNetworkImage(
                  imageUrl: path,
                  imageBuilder: (context, provider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          color: AppColors.black.withValues(alpha: .1),
                          blurRadius: 6,
                          spreadRadius: -4,
                        ),

                        BoxShadow(
                          offset: Offset(0, 10),
                          color: AppColors.black.withValues(alpha: .1),
                          blurRadius: 15,
                          spreadRadius: -3,
                        ),
                      ],
                      image: DecorationImage(
                        image: provider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.person),
                )
              : ClipOval(child: Image.file(File(path), fit: BoxFit.cover)),
        ),
        Transform.translate(
          offset: Offset(90, 90),
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.themeColor,
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: () async {
                final List<String> photos = await Utility.getPhotos(
                  isMultiple: false,
                );
                if (photos.isNotNullOrEmpty()) {
                  onPicTap(photos.first);
                }
              },
              child: Icon(Icons.edit, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
