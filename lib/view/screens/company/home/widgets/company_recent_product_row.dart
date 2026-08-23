import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class CompanyRecentProductRow extends StatelessWidget {
  const CompanyRecentProductRow({required this.product, super.key});

  final Product product;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppResponsive.value(12, tablet: 16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppResponsive.value(14, tablet: 18),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.inventory_2_outlined,
            color: AppColors.themeColor,
            size: AppResponsive.value(24, tablet: 28),
          ),
          Gap(AppResponsive.value(12, tablet: 16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: interW700.copyWith(
                    fontSize: AppResponsive.font(15),
                    color: AppColors.color1A1A2D,
                  ),
                ),
                Gap(AppResponsive.value(4, tablet: 6)),
                Text(
                  product.companyName ?? '',
                  style: companyProfileUploadDescription,
                ),
              ],
            ),
          ),
          Text(
            '${product.views ?? 0} ${'views'.tr}',
            style: companyProfileUploadDescription,
          ),
        ],
      ),
    );
  }
}
