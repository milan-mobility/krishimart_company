import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/extensions/string_ext.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/placeholder_image.dart';
import 'package:krishi_mart/view/screens/company/product/list/widgets/product_row_action.dart';

class ProductRow extends StatelessWidget {
  const ProductRow({
    required this.product,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppResponsive.value(12, tablet: 16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppResponsive.value(14, tablet: 18),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.themeColor.withValues(alpha: .06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          (product.primaryImage?.image.isNotNullAndEmpty() == true)
              ? CachedNetworkImage(
                  imageUrl: (product.primaryImage!.image ?? '').imageUrl(),
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
          Gap(AppResponsive.value(11, tablet: 14)),
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
                Gap(AppResponsive.value(3, tablet: 5)),
                Text(
                  product.company?.companyName ?? '',
                  style: companyProfileUploadDescription,
                ),
                Gap(AppResponsive.value(4, tablet: 6)),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.visibility_outlined,
                      color: AppColors.formHint,
                      size: AppResponsive.value(12),
                    ),
                    Gap(AppResponsive.value(4)),
                    Text(
                      '${product.views ?? 0} ${'views'.tr}',
                      style: companyProfileUploadDescription,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(AppResponsive.value(8, tablet: 10)),
          Column(
            children: <Widget>[
              ProductRowAction(
                label: 'Edit',
                icon: Icons.edit_outlined,
                backgroundColor: AppColors.productEditBackground,
                foregroundColor: AppColors.color1F6D1A,
                onTap: onEdit,
              ),
              Gap(AppResponsive.value(7, tablet: 9)),
              ProductRowAction(
                label: 'Del',
                icon: Icons.delete_outline,
                backgroundColor: AppColors.productDeleteBackground,
                foregroundColor: AppColors.roleDealer,
                onTap: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
