import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/dealer_dashboard_product.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/screens/dealer/home/widgets/dealer_product_row.dart';

class DealerProductsSection extends StatelessWidget {
  const DealerProductsSection({required this.products, super.key});

  final List<DealerDashboardProduct> products;

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text('My Products'.tr, style: companyProfileSectionTitle),
            ),
            Text(
              'Manage'.tr,
              style: interW600.copyWith(color: AppColors.color1F6D1A),
            ),
          ],
        ),
        Gap(AppResponsive.value(12, tablet: 14)),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: AppResponsive.value(10, tablet: 12)),
          itemBuilder: (final BuildContext context, final int index) =>
              DealerProductRow(product: products[index]),
        ),
      ],
    );
  }
}
