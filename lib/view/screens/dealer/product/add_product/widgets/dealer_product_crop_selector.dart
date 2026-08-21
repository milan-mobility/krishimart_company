import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/id_name_model.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class DealerProductCropSelector extends StatelessWidget {
  const DealerProductCropSelector({
    required this.crops,
    required this.selectedCrops,
    required this.onChanged,
    super.key,
  });

  final List<IdName> crops;
  final List<IdName> selectedCrops;
  final ValueChanged<List<IdName>> onChanged;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: 'Crops'.tr,
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
        InkWell(
          onTap: () => _showCropPicker(context),
          borderRadius: BorderRadius.circular(AppResponsive.value(8)),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: AppResponsive.value(12),
              vertical: AppResponsive.value(14),
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.formBorder),
              borderRadius: BorderRadius.circular(AppResponsive.value(8)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    selectedCrops.isEmpty
                        ? 'Select crops'.tr
                        : selectedCrops
                              .map((final IdName crop) => crop.name)
                              .join(', '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: interW400.copyWith(
                      fontSize: 15,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showCropPicker(final BuildContext context) async {
    final List<IdName> draftSelection = List<IdName>.of(selectedCrops);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (final BuildContext context) {
        return StatefulBuilder(
          builder: (final BuildContext context, final StateSetter setState) {
            return SafeArea(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * .6,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(AppResponsive.value(16)),
                      child: Text('Select crops'.tr, style: productFormTitle),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: crops.length,
                        itemBuilder:
                            (final BuildContext context, final int index) {
                              final IdName crop = crops[index];
                              final bool isSelected = draftSelection.any(
                                (final IdName item) => item.id == crop.id,
                              );
                              return CheckboxListTile(
                                value: isSelected,
                                title: Text(crop.name ?? ''),
                                activeColor: AppColors.themeColor,
                                onChanged: (final bool? selected) {
                                  setState(() {
                                    if (selected ?? false) {
                                      draftSelection.add(crop);
                                    } else {
                                      draftSelection.removeWhere(
                                        (final IdName item) =>
                                            item.id == crop.id,
                                      );
                                    }
                                  });
                                },
                              );
                            },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppResponsive.value(16)),
                      child: FilledButton(
                        onPressed: () {
                          onChanged(draftSelection);
                          Navigator.of(context).pop();
                        },
                        child: Text('Done'.tr),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
