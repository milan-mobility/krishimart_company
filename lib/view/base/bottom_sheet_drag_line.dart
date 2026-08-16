import 'package:flutter/material.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';

class BottomSheetDragLine extends StatelessWidget {
  const BottomSheetDragLine({super.key, this.width});

  final double? width;

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: AppResponsive.space(5),
      width: AppResponsive.space(width ?? 130),
      margin: EdgeInsets.only(bottom: AppResponsive.space(5)),
      decoration: BoxDecoration(
        color: AppColors.color2D5A27,
        borderRadius: BorderRadius.circular(AppResponsive.space(2.5)),
      ),
    );
  }
}
