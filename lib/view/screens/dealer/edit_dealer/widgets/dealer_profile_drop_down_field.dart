import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/id_name_model.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/common_drop_down_field.dart';

class DealerProfileDropDownField extends StatelessWidget {
  const DealerProfileDropDownField({
    required this.label,
    required this.hintText,
    required this.items,
    required this.value,
    this.fillColor,
    required this.onChanged,
    super.key,
  });

  final String label;
  final String hintText;
  final Color? fillColor;
  final List<IdName> items;
  final IdName? value;
  final ValueChanged<IdName?> onChanged;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: label.tr,
            style: interW500.copyWith(
              fontSize: 14,
              color: AppColors.color9CA3AF,
            ),
            children: <InlineSpan>[
              TextSpan(
                text: ' *',
                style: companyProfileFieldLabel.copyWith(
                  color: AppColors.roleDealer,
                ),
              ),
            ],
          ),
        ),
        Gap(AppResponsive.value(6, tablet: 8)),
        CommonDropDownField<IdName>(
          height: AppResponsive.value(50, tablet: 50),
          list: items,
          selectedItem: value,
          onItemChange: onChanged,
          itemAsString: (final IdName? item) => item?.name ?? '',
          hintText: hintText.tr,
          showPrefixIcon: false,
          showSearchBox: true,
          fillColor: fillColor ?? Colors.white,
          textColor: AppColors.color191C1C,
        ),
      ],
    );
  }
}
