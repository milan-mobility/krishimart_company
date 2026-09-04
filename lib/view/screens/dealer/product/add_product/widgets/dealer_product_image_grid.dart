import 'dart:io';

import 'package:flutter/material.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';

class DealerProductImageGrid extends StatelessWidget {
  const DealerProductImageGrid({
    required this.imagePaths,
    required this.onRemove,
    super.key,
  });

  final List<String> imagePaths;
  final ValueChanged<int> onRemove;

  @override
  Widget build(final BuildContext context) {
    if (imagePaths.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: imagePaths.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (final BuildContext context, final int index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppResponsive.value(8)),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.file(File(imagePaths[index]), fit: BoxFit.cover),
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
        );
      },
    );
  }
}
