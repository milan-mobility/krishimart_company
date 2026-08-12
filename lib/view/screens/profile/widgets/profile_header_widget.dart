import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    required this.name,
    required this.businessType,
    super.key,
  });

  final String name;
  final String businessType;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppResponsive.value(18, tablet: 24)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppResponsive.value(18)),
        border: Border.all(color: AppColors.formBorder),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: AppResponsive.value(72, tablet: 88),
            height: AppResponsive.value(72, tablet: 88),
            padding: EdgeInsets.all(AppResponsive.value(18, tablet: 22)),
            decoration: const BoxDecoration(
              color: AppColors.colorE8F3EC,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              Assets.svg.icUser,
              colorFilter: const ColorFilter.mode(
                AppColors.themeColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: AppResponsive.value(16, tablet: 20)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: profileName,
                ),
                SizedBox(height: AppResponsive.value(5)),
                Text(
                  businessType,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: profileRole,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
