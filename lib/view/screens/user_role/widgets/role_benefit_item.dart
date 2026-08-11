import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class RoleBenefitItem extends StatelessWidget {
  const RoleBenefitItem({
    required this.icon,
    required this.title,
    required this.description,
    super.key,
  });

  final Widget icon;
  final String title;
  final String description;

  @override
  Widget build(final BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          SizedBox(
            width: AppResponsive.value(52, tablet: 60),
            height: AppResponsive.value(52, tablet: 60),
            child: icon,
          ),
          Gap(AppResponsive.value(8, tablet: 10)),
          Text(title.tr, style: userRoleBenefitTitle),
          Gap(AppResponsive.value(2, tablet: 4)),
          Text(
            description.tr,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: userRoleBenefitDescription,
          ),
        ],
      ),
    );
  }
}
