import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

import '../../gen/assets.gen.dart';

class CommonDropDownField<T> extends StatelessWidget {
  const CommonDropDownField({
    super.key,
    this.height,
    this.selectedItem,
    required this.list,
    required this.onItemChange,
    required this.itemAsString,
    this.textColor = AppColors.color1A1A2D,
    this.showSearchBox = true,
    this.enabled = true,
    this.hintText,
    this.showPrefixIcon = true,
    this.fillColor = AppColors.colorECEEED,
  });

  final T? selectedItem;
  final List<T> list;
  final Function(T? item) onItemChange;
  final String Function(T? item) itemAsString;
  final Color textColor;
  final Color? fillColor;
  final bool enabled;
  final bool showSearchBox;
  final double? height;
  final String? hintText;
  final bool showPrefixIcon;

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: height ?? 50,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(
          color: AppColors.colorBFC9C1.withValues(alpha: .5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownSearch<T>(
        items: list,
        enabled: enabled,
        selectedItem: selectedItem,
        itemAsString: (final T str) => itemAsString(str).capitalize ?? '',
        popupProps: PopupProps<T>.modalBottomSheet(
          onDismissed: () {
            FocusScope.of(Get.context!).unfocus();
          },
          showSearchBox: showSearchBox,
          searchDelay: const Duration(milliseconds: 100),
          listViewProps: ListViewProps(
            padding: EdgeInsets.symmetric(
              horizontal: 1.0,
              vertical: showSearchBox ? 0 : 20.0,
            ),
          ),
          itemBuilder:
              (
                final BuildContext context,
                final T item,
                final bool isSelected,
              ) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.colorBFC9C1,
                        width: .5,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      itemAsString(item).capitalize ?? '',
                      style: interW600,
                    ),
                    tileColor: isSelected
                        ? Colors.grey.withValues(alpha: 0.3)
                        : Colors.transparent,
                    selectedTileColor: Colors.grey.withValues(alpha: 0.3),
                  ),
                );
              },
          searchFieldProps: TextFieldProps(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 16.0,
            ),
            textInputAction: TextInputAction.done,
            style: interW400,
            decoration: InputDecoration(
              hintText: 'Search'.tr,
              hintStyle: interW400,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.colorBFC9C1,
                  width: 1.0,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.colorBFC9C1,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.colorBFC9C1,
                  width: 1.0,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.colorBFC9C1,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
        dropdownBuilder: (final BuildContext context, final T? item) {
          return Row(
            children: [
              if (showPrefixIcon) ...<Widget>[
                SvgPicture.asset(Assets.svg.icFormLocation),
                Gap(AppResponsive.space(8)),
              ],
              Expanded(
                child: Text(
                  item == null
                      ? hintText ?? ''
                      : itemAsString(item).capitalize ?? '',
                  style: interW400.copyWith(
                    fontSize: 14,
                    color: item == null
                        ? AppColors.formHint
                        : enabled
                        ? textColor
                        : AppColors.themeColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          );
        },
        dropdownButtonProps: DropdownButtonProps(
          icon: SvgPicture.asset(Assets.svg.icArrowDown),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          textAlignVertical: TextAlignVertical.center,
          dropdownSearchDecoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.0),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.0),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.0),
            ),
          ),
        ),
        onChanged: (final T? value) => onItemChange.call(value),
      ),
    );
  }
}
