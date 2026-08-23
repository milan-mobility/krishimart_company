import 'package:flutter/material.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';

class ExistingProductImageGrid extends StatelessWidget {
  const ExistingProductImageGrid({
    required this.imageUrls,
    required this.onRemove,
    super.key,
  });

  final List<String> imageUrls;
  final ValueChanged<int> onRemove;

  @override
  Widget build(final BuildContext context) {
    if (imageUrls.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: imageUrls.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (final BuildContext context, final int index) => ClipRRect(
        borderRadius: BorderRadius.circular(AppResponsive.value(8)),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              imageUrls[index],
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
                  onTap: () => onRemove(index),
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
      ),
    );
  }
}
