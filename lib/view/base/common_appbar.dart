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
    this.subtitle,
    this.subtitleColor,
    this.leadingIconColor,
  });

  final String title;
  final List<Widget>? actions;
  final VoidCallback? onLeading;
  final Color? backgroundColor;
  final String? iconStr;
  final double? leadingWidth;
  final Color? txtColor;
  final String? subtitle;
  final Color? subtitleColor;
  final Color? leadingIconColor;

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
                child: SvgPicture.asset(
                  iconStr ?? Assets.svg.icBack,
                  colorFilter: leadingIconColor == null
                      ? null
                      : ColorFilter.mode(leadingIconColor!, BlendMode.srcIn),
                ),
              )
            : SvgPicture.asset(
                iconStr ?? Assets.svg.icBack,
                colorFilter: leadingIconColor == null
                    ? null
                    : ColorFilter.mode(leadingIconColor!, BlendMode.srcIn),
              ),
      ),
      centerTitle: false,
      titleSpacing: AppResponsive.space(10),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: interW600.copyWith(
              fontSize: AppResponsive.font(18),
              color: txtColor ?? AppColors.themeColor,
            ),
          ),
          if (subtitle != null) ...<Widget>[
            SizedBox(height: AppResponsive.space(2)),
            Text(
              subtitle!,
              style: interW400.copyWith(
                fontSize: AppResponsive.font(12),
                color: subtitleColor ?? txtColor ?? AppColors.themeColor,
              ),
            ),
          ],
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(AppResponsive.space(subtitle == null ? 56 : 76));

  @override
  Widget get child => throw UnimplementedError();
}
