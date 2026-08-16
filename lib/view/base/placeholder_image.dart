import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';

import '../../gen/assets.gen.dart';

class PlaceholderImage extends StatelessWidget {
  const PlaceholderImage({
    super.key,
    this.width,
    this.height,
    this.isCircle = false,
    this.isSvg = true,
    this.pngPath,
    this.radius,
  });

  final double? width;
  final double? height;
  final bool? isCircle;
  final bool? isSvg;
  final String? pngPath;
  final double? radius;

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: AppResponsive.space(height ?? 50),
      width: AppResponsive.space(width ?? 50),
      decoration: BoxDecoration(
        shape: (isCircle ?? false) ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: (isSvg ?? false)
          ? ClipRRect(
              borderRadius: BorderRadius.circular(
                AppResponsive.space((isCircle ?? false) ? 60 : radius ?? 0),
              ),
              child: SvgPicture.asset(
                Assets.svg.icImagePlaceholder,
                height: AppResponsive.space(height ?? 50),
                width: AppResponsive.space(width ?? 50),
              ),
            )
          : Image.asset(
              pngPath!,
              height: AppResponsive.space(height ?? 50),
              width: AppResponsive.space(width ?? 50),
            ),
    );
  }
}
