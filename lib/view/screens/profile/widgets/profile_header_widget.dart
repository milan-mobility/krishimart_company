import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/controllers/common_controller.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/extensions/string_ext.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/app_enums.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({required this.role, super.key});

  final String role;

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<CommonController>(
      builder: (final CommonController commonController) {
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
              commonController.userProfileModel?.data?.user?.profilePhotoUrl
                          .isNotNullAndEmpty() ==
                      true
                  ? CachedNetworkImage(
                      imageUrl:
                          commonController
                              .userProfileModel
                              ?.data
                              ?.user
                              ?.profilePhotoUrl ??
                          '',
                      imageBuilder: (context, provider) => Container(
                        width: AppResponsive.value(72, tablet: 88),
                        height: AppResponsive.value(72, tablet: 88),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: provider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.person),
                    )
                  : Container(
                      width: AppResponsive.value(72, tablet: 88),
                      height: AppResponsive.value(72, tablet: 88),
                      padding: EdgeInsets.all(
                        AppResponsive.value(18, tablet: 22),
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.colorE8F3EC,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          role == UserType.company.name
                              ? (commonController
                                            .userProfileModel
                                            ?.data
                                            ?.profile
                                            ?.companyName ??
                                        '')
                                    .companyInitials()
                              : (commonController
                                            .userProfileModel
                                            ?.data
                                            ?.profile
                                            ?.shopName ??
                                        '')
                                    .companyInitials(),
                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontSize: AppResponsive.value(26, tablet: 32),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
              Gap(AppResponsive.value(16, tablet: 20)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    role == UserType.company.name
                        ? commonController
                                  .userProfileModel
                                  ?.data
                                  ?.profile
                                  ?.companyName ??
                              ''
                        : commonController
                                  .userProfileModel
                                  ?.data
                                  ?.profile
                                  ?.shopName ??
                              '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: profileName,
                  ),
                  Gap(AppResponsive.value(5)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.color1F6D1A,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.verified, size: 15, color: Colors.white),
                        Gap(AppResponsive.value(5, tablet: 8, largeTablet: 13)),
                        Text(
                          ((commonController
                                          .userProfileModel
                                          ?.data
                                          ?.profile
                                          ?.verificationStatus) ??
                                      '')
                                  .capitalizeFirst ??
                              '',
                          style: interW500.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  if (Get.find<SharedPreferenceHelper>().getUserRole ==
                      UserType.company.name) {
                    Get.toNamed(RouteHelper.editCompanyProfile);
                  } else {
                    Get.toNamed(RouteHelper.editDealerProfile);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.edit, color: AppColors.white, size: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
