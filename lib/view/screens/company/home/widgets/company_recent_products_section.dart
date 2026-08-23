import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/screens/company/home/widgets/company_recent_product_row.dart';

class CompanyRecentProductsSection extends StatelessWidget {
  const CompanyRecentProductsSection({required this.products, super.key});

  final List<Product> products;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'My Products'.tr,
          style: interW600.copyWith(fontSize: 18, color: AppColors.color0F5238),
        ),
        Gap(AppResponsive.value(12, tablet: 14)),
        if (products.isEmpty)
          Text('No products found'.tr, style: companyProfileUploadDescription)
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: AppResponsive.value(10, tablet: 12)),
            itemBuilder: (final BuildContext context, final int index) {
              return CompanyRecentProductRow(product: products[index]);
            },
          ),
      ],
    );
  }
}
