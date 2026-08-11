import 'package:flutter/material.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';

class ProductFormCard extends StatelessWidget {
  const ProductFormCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppResponsive.value(16, tablet: 22)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppResponsive.value(14, tablet: 18),
        ),
        border: Border.all(color: AppColors.productUploadBorder),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.themeColor.withValues(alpha: .04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
