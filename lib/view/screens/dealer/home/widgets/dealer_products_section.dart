import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/view/screens/dealer/home/widgets/dealer_product_row.dart';

class DealerProductsSection extends StatelessWidget {
  const DealerProductsSection({required this.products, super.key});

  final List<Product> products;

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
            InkWell(
              onTap: () => Get.toNamed(RouteHelper.productList),
              borderRadius: BorderRadius.circular(AppResponsive.value(6)),
              child: Padding(
                padding: EdgeInsets.all(AppResponsive.value(4)),
                child: Text(
                  'View All'.tr,
                  style: interW400.copyWith(
                    fontSize: 16,
                    color: AppColors.color1E3A8A,
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap(AppResponsive.value(12, tablet: 14)),
        if (products.isEmpty)
          Text('No products found'.tr, style: companyProfileUploadDescription)
        else
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
