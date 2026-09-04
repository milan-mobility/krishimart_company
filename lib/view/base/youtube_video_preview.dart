import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class YouTubeVideoPreview extends StatelessWidget {
  const YouTubeVideoPreview({required this.videoId, super.key});

  final String videoId;

  @override
  Widget build(final BuildContext context) {
    final double borderRadius = AppResponsive.space(10);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('YouTube Preview'.tr, style: youtubePreviewTitle),
        SizedBox(height: AppResponsive.space(8)),
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const ColoredBox(
                      color: AppColors.productImageBackground,
                    ),
                    errorWidget: (context, url, error) => const ColoredBox(
                      color: AppColors.productImageBackground,
                    ),
                  ),
                ),
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.themeColor,
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
