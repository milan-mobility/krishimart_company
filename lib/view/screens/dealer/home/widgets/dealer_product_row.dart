import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/dealer_dashboard_product.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class DealerProductRow extends StatelessWidget {
  const DealerProductRow({required this.product, super.key});

  final DealerDashboardProduct product;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppResponsive.value(10, tablet: 14)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppResponsive.value(12, tablet: 16),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.themeColor.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: AppResponsive.value(50, tablet: 60),
            height: AppResponsive.value(50, tablet: 60),
            decoration: BoxDecoration(
              color: AppColors.productImageBackground,
              borderRadius: BorderRadius.circular(AppResponsive.value(8)),
            ),
            child: Icon(
              Icons.agriculture_outlined,
              color: AppColors.color1F6D1A,
              size: AppResponsive.value(26, tablet: 30),
            ),
          ),
          Gap(AppResponsive.value(12, tablet: 14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.name,
                  style: interW700.copyWith(color: AppColors.color1A1A2D),
                ),
                Gap(AppResponsive.value(3)),
                Text(
                  '${product.category.tr} • ${product.quantity}',
                  style: userRoleOptionDescription,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                product.price,
                style: interW600.copyWith(color: AppColors.color1F6D1A),
              ),
              Gap(AppResponsive.value(5)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppResponsive.value(6),
                  vertical: AppResponsive.value(2),
                ),
                decoration: BoxDecoration(
                  color: AppColors.colorE8F5E9,
                  borderRadius: BorderRadius.circular(AppResponsive.value(5)),
                ),
                child: Text(
                  'In Stock'.tr,
                  style: companyProfileCategoryTitle.copyWith(
                    fontSize: AppResponsive.font(8),
                    color: AppColors.color1F6D1A,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
