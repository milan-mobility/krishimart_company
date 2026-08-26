import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/extensions/string_ext.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/placeholder_image.dart';

class DealerProductRow extends StatelessWidget {
  const DealerProductRow({required this.product, super.key});

  final Product product;

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
          (product.primaryImage?.imageUrl.isNotNullAndEmpty() == true)
              ? CachedNetworkImage(
                  imageUrl: product.primaryImage!.imageUrl!,
                  imageBuilder:
                      (
                        final BuildContext context,
                        final ImageProvider<Object> imageProvider,
                      ) => Container(
                        width: AppResponsive.value(52, tablet: 62),
                        height: AppResponsive.value(52, tablet: 62),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppResponsive.value(11),
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  placeholder: (final BuildContext context, final String url) =>
                      PlaceholderImage(
                        width: AppResponsive.value(52, tablet: 62),
                        height: AppResponsive.value(52, tablet: 62),
                      ),
                  errorWidget: (context, url, error) => PlaceholderImage(
                    width: AppResponsive.value(52, tablet: 62),
                    height: AppResponsive.value(52, tablet: 62),
                  ),
                )
              : PlaceholderImage(
                  width: AppResponsive.value(52, tablet: 62),
                  height: AppResponsive.value(52, tablet: 62),
                ),
          Gap(AppResponsive.value(12, tablet: 14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: interW700.copyWith(color: AppColors.color1A1A2D),
                ),
                Gap(AppResponsive.value(3)),
                Text(
                  '${product.category?.name ?? ''} • ${product.dose ?? ''}',
                  style: userRoleOptionDescription,
                ),
              ],
            ),
          ),
          Gap(AppResponsive.value(5)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppResponsive.value(6),
              vertical: AppResponsive.value(4),
            ),
            decoration: BoxDecoration(
              color: AppColors.colorE8F5E9,
              borderRadius: BorderRadius.circular(
                AppResponsive.value(10, tablet: 20),
              ),
            ),
            child: Text(
              product.status ?? '',
              style: companyProfileCategoryTitle.copyWith(
                fontSize: AppResponsive.font(12),
                color: AppColors.color1F6D1A,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
