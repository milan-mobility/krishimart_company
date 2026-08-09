import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.btnText,
    required this.onPressed,
    this.btnBgColor,
    this.height,
    this.width,
    this.paddingHorizontal,
    this.borderRadius,
    this.btnTxtColor,
    this.side,
    this.icon, // New parameter for icon
    this.iconSpacing, // Optional spacing between icon and text
    this.textStyle,
    this.iconColor,
    this.fontSize,
  });

  final double? height;
  final double? width;
  final String btnText;
  final VoidCallback? onPressed;
  final Color? btnBgColor;
  final double? paddingHorizontal;
  final double? borderRadius;
  final Color? btnTxtColor;
  final Color? iconColor;
  final BorderSide? side;
  final double? fontSize;
  final String? icon; // Icon parameter
  final double? iconSpacing; // Spacing between icon and text
  final TextStyle? textStyle;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: height ?? AppResponsive.space(50),
      width: width ?? AppResponsive.space(double.infinity),
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              icon: SvgPicture.asset(
                icon ?? '',
                colorFilter: iconColor != null
                    ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                    : null,
              ),
              iconAlignment: IconAlignment.end,
              label: Text(
                btnText,
                textAlign: TextAlign.center,
                style:
                    textStyle ??
                    interW600.copyWith(
                      fontSize: fontSize ?? AppResponsive.font(14),
                      color: btnTxtColor ?? AppColors.white,
                    ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: btnBgColor ?? AppColors.themeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius ?? AppResponsive.space(10.0),
                  ),
                  side:
                      side ??
                      BorderSide(
                        color: Colors.transparent,
                        width: AppResponsive.space(0),
                      ),
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: btnBgColor ?? AppColors.themeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius ?? AppResponsive.space(10.0),
                  ),
                ),
                side:
                    side ??
                    BorderSide(
                      color: Colors.transparent,
                      width: AppResponsive.space(0),
                    ),
              ),
              child: Text(
                btnText,
                textAlign: TextAlign.center,
                style:
                    textStyle ??
                    interW600.copyWith(
                      fontSize: fontSize ?? AppResponsive.font(14),
                      color: btnTxtColor ?? AppColors.white,
                    ),
              ),
            ),
    );
  }
}
