import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krishi_mart/data/network/api_end_points.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';

class CompanyCategoryImage extends StatelessWidget {
  const CompanyCategoryImage({required this.imageUrl, super.key});

  final String? imageUrl;

  @override
  Widget build(final BuildContext context) {
    final String normalizedUrl = imageUrl?.trim() ?? '';
    final bool hasImage = normalizedUrl.isNotEmpty;
    final String resolvedUrl = normalizedUrl.startsWith('http')
        ? normalizedUrl
        : '${Endpoints.imageUrl}$normalizedUrl';
    final bool isSvg = Uri.parse(
      resolvedUrl,
    ).path.toLowerCase().endsWith('.svg');
    final double size = AppResponsive.value(20, tablet: 24);

    if (!hasImage) {
      return Icon(
        Icons.category_outlined,
        size: size,
        color: AppColors.themeColor,
      );
    }

    if (isSvg) {
      return SvgPicture.network(
        resolvedUrl,
        width: size,
        height: size,
        placeholderBuilder: (final BuildContext context) => SizedBox(
          width: size,
          height: size,
          child: const Center(child: CircularProgressIndicator.adaptive()),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: resolvedUrl,
      width: size,
      height: size,
      fit: BoxFit.contain,
      placeholder: (final BuildContext context, final String url) => SizedBox(
        width: size,
        height: size,
        child: const Center(child: CircularProgressIndicator.adaptive()),
      ),
      errorWidget:
          (final BuildContext context, final String url, final Object error) =>
              Icon(
                Icons.category_outlined,
                size: size,
                color: AppColors.themeColor,
              ),
    );
  }
}
