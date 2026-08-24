import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/view/screens/dealer/home/controller/dealer_home_controller.dart';

class DealerBannerCarousel extends StatelessWidget {
  const DealerBannerCarousel({required this.controller, super.key});

  final DealerHomeController controller;

  @override
  Widget build(final BuildContext context) {
    if (controller.banners.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(AppResponsive.value(10, tablet: 14)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppResponsive.value(14, tablet: 18),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.themeColor.withValues(alpha: .06),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: AppResponsive.value(138, tablet: 164),
            child: PageView.builder(
              controller: controller.bannerPageController,
              itemCount: controller.banners.length,
              onPageChanged: controller.onBannerChanged,
              itemBuilder: (final BuildContext context, final int index) {
                final String? imageUrl = controller.banners[index].imageUrl;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppResponsive.value(9, tablet: 12),
                  ),
                  child: imageUrl == null || imageUrl.isEmpty
                      ? const ColoredBox(color: AppColors.dashboardBanner)
                      : CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: (context, url) => const ColoredBox(
                            color: AppColors.dashboardBanner,
                          ),
                          errorWidget: (context, url, error) =>
                              const ColoredBox(
                                color: AppColors.dashboardBanner,
                              ),
                        ),
                );
              },
            ),
          ),
          Gap(AppResponsive.value(10, tablet: 12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(controller.banners.length, (
              final int index,
            ) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: AppResponsive.value(
                  controller.currentBanner == index ? 18 : 6,
                ),
                height: AppResponsive.value(6),
                margin: EdgeInsets.symmetric(
                  horizontal: AppResponsive.value(3),
                ),
                decoration: BoxDecoration(
                  color: controller.currentBanner == index
                      ? AppColors.themeColor
                      : AppColors.colorC1C8C2,
                  borderRadius: BorderRadius.circular(AppResponsive.value(5)),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
