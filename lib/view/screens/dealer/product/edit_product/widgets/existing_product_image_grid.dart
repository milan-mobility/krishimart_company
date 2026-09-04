import 'package:flutter/material.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';

class ExistingProductImageGrid extends StatelessWidget {
  const ExistingProductImageGrid({
    required this.images,
    required this.imageUrlBuilder,
    required this.onRemove,
    super.key,
  });

  final List<PrimaryImage> images;
  final String Function(String path) imageUrlBuilder;
  final ValueChanged<PrimaryImage> onRemove;

  @override
  Widget build(final BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (final BuildContext context, final int index) {
        final PrimaryImage image = images[index];
        final String imageUrl = imageUrlBuilder(
          image.imageUrl ?? image.image ?? '',
        );
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppResponsive.value(8)),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.productImageBackground,
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: AppColors.color404943,
                  ),
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: Material(
                  color: AppColors.white,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () => onRemove(image),
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Icon(
                        Icons.close,
                        size: AppResponsive.value(16),
                        color: AppColors.roleDealer,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
