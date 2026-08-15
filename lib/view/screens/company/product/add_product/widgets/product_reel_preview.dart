import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:video_player/video_player.dart';

class ProductReelPreview extends StatelessWidget {
  const ProductReelPreview({
    required this.videoController,
    required this.onTogglePlayback,
    required this.onRemove,
    super.key,
  });

  final VideoPlayerController videoController;
  final VoidCallback onTogglePlayback;
  final VoidCallback onRemove;

  @override
  Widget build(final BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppResponsive.value(10)),
      child: AspectRatio(
        aspectRatio: videoController.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            VideoPlayer(videoController),
            IconButton.filled(
              onPressed: onTogglePlayback,
              style: IconButton.styleFrom(
                backgroundColor: AppColors.themeColor.withValues(alpha: .78),
                foregroundColor: AppColors.white,
              ),
              icon: Icon(
                videoController.value.isPlaying
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
              ),
            ),
            Positioned(
              top: AppResponsive.value(8),
              right: AppResponsive.value(8),
              child: IconButton.filled(
                onPressed: onRemove,
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.productDeleteBackground,
                  foregroundColor: AppColors.roleDealer,
                ),
                icon: const Icon(Icons.close_rounded),
              ),
            ),
            Positioned(
              left: AppResponsive.value(12),
              bottom: AppResponsive.value(10),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.check_circle, color: AppColors.colorA4F792),
                  Gap(AppResponsive.value(6)),
                  Text(
                    'Reel ready'.tr,
                    style: productUploadLabel.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
