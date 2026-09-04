import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/common_drop_down_field.dart';

class ProductDropdownField<T> extends StatelessWidget {
  const ProductDropdownField({
    required this.label,
    required this.hintText,
    required this.items,
    required this.selectedItem,
    required this.itemAsString,
    required this.onChanged,
    super.key,
  });

  final String label;
  final String hintText;
  final List<T> items;
  final T? selectedItem;
  final String Function(T item) itemAsString;
  final ValueChanged<T?> onChanged;

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
        FormField<T>(
          initialValue: selectedItem,

          validator: (final T? value) =>
              value == null ? 'This field is required'.tr : null,
          builder: (final FormFieldState<T> field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonDropDownField<T>(
                  list: items,
                  selectedItem: selectedItem,
                  onItemChange: (final T? item) {
                    field.didChange(item);
                    onChanged(item);
                  },
                  itemAsString: (final T? item) =>
                      item == null ? '' : itemAsString(item),
                  hintText: hintText.tr,
                  showPrefixIcon: false,
                  fillColor: AppColors.white,
                ),
                if (field.hasError)
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppResponsive.value(4, tablet: 6),
                      left: AppResponsive.value(12),
                    ),
                    child: Text(
                      field.errorText ?? '',
                      style: interW400.copyWith(
                        fontSize: AppResponsive.font(12),
                        color: AppColors.roleDealer,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
