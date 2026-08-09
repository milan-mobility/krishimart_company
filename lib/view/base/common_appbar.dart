import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

import '../../gen/assets.gen.dart';

class CommonAppbar extends StatelessWidget implements PreferredSize {
  const CommonAppbar({
    super.key,
    required this.title,
    this.actions,
    this.onLeading,
    this.backgroundColor,
    this.iconStr,
    this.leadingWidth,
    this.txtColor,
  });

  final String title;
  final List<Widget>? actions;
  final VoidCallback? onLeading;
  final Color? backgroundColor;
  final String? iconStr;
  final double? leadingWidth;
  final Color? txtColor;

  @override
  Widget build(final BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: backgroundColor ?? Colors.white,
      leading: IconButton(
        padding: EdgeInsets.zero,
        onPressed:
            onLeading ??
            () {
              Get.back();
            },
        icon: Directionality.of(context) == TextDirection.rtl
            ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.1416), // flip horizontally
                child: SvgPicture.asset(iconStr ?? Assets.svg.icBack),
              )
            : SvgPicture.asset(iconStr ?? Assets.svg.icBack),
      ),
      centerTitle: false,
      titleSpacing: AppResponsive.space(10),
      title: Text(
        title,
        style: interW600.copyWith(
          fontSize: AppResponsive.font(18),
          color: txtColor ?? AppColors.themeColor,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppResponsive.space(56));

  @override
  Widget get child => throw UnimplementedError();
}
