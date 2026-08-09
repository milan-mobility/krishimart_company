import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/controllers/loader_controller.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';

class GlobalLoader extends StatelessWidget {
  final Widget child;

  const GlobalLoader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoaderController>();

    return Stack(
      children: [
        child,
        Obx(() {
          if (!controller.isLoading.value) return const SizedBox();
          return Container(
            color: AppColors.themeColor.withValues(alpha: 0.2),
            child: Center(
              child: SpinKitThreeBounce(
                color: AppColors.themeColor,
                size: AppResponsive.space(30),
              ),
            ),
          );
        }),
      ],
    );
  }
}
