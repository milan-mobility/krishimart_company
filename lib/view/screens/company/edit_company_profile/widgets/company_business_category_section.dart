import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/widgets/company_category_tile.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/widgets/company_profile_section_card.dart';
import 'package:krishi_mart/view/screens/company/edit_company_profile/controller/edit_company_profile_controller.dart';

import '../../../../../data/model/category_model.dart';

class CompanyBusinessCategorySection extends StatelessWidget {
  const CompanyBusinessCategorySection({required this.controller, super.key});

  final EditCompanyProfileController controller;

  @override
  Widget build(final BuildContext context) {
    return CompanyProfileSectionCard(
      title: 'Business Category',
      iconAsset: Assets.png.icBusinessForm.path,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Select Business Category *'.tr,
            style: companyProfileFieldLabel,
          ),
          Gap(AppResponsive.value(9, tablet: 12)),
          Row(
            children: controller.commonController.categories
                .map(
                  (final Category category) => CompanyCategoryTile(
                    title: category.name ?? '',
                    imageUrl: category.iconUrl,
                    isSelected: controller.isCategorySelected(category),
                    onTap: () => controller.toggleCategory(category),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
