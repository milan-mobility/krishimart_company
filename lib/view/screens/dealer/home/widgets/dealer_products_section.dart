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
            Text(
              'My Products'.tr,
              style: interW600.copyWith(
                fontSize: 18,
                color: AppColors.color0F5238,
              ),
            ),
            const Spacer(),
            Text(
              'Manage'.tr,
              style: interW400.copyWith(
                fontSize: 16,
                color: AppColors.color1E3A8A,
              ),
            ),
          ],
        ),
        Gap(AppResponsive.value(12, tablet: 14)),
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
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
