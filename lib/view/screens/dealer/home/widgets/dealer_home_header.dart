import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/routes/route_helper.dart';

class DealerHomeHeader extends StatelessWidget {
  const DealerHomeHeader({required this.dealerName, super.key});

  final String dealerName;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppResponsive.value(18, tablet: 28),
        AppResponsive.value(16, tablet: 20),
        AppResponsive.value(12, tablet: 20),
        AppResponsive.value(16, tablet: 20),
      ),
      color: AppColors.themeColor,
      child: SafeArea(
        bottom: false,
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: AppResponsive.value(21, tablet: 25),
              backgroundColor: AppColors.white.withValues(alpha: .2),
              child: ClipOval(
                child: SvgPicture.asset(
                  Assets.svg.icUser,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(width: AppResponsive.value(10, tablet: 14)),
            Expanded(
              child: Text(
                dealerName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: interW700.copyWith(
                  fontSize: AppResponsive.font(18),
                  color: AppColors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed(RouteHelper.notificationScreen);
              },
              icon: Icon(
                Icons.notifications_none,
                color: AppColors.white,
                size: AppResponsive.value(24, tablet: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
