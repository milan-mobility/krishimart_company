import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/screens/dealer/product/add_product/widgets/dealer_product_type_tab.dart';

class DealerProductTypeTabs extends StatelessWidget {
  const DealerProductTypeTabs({
    required this.selectedTab,
    required this.onNormalProductSelected,
    required this.onDemoProductConfirmed,
    super.key,
  });

  final int selectedTab;
  final VoidCallback onNormalProductSelected;
  final Future<void> Function() onDemoProductConfirmed;

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: AppResponsive.value(40),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppResponsive.value(10)),
        border: Border.all(color: AppColors.roleCompany),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: onNormalProductSelected,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppResponsive.value(10)),
                bottomLeft: Radius.circular(AppResponsive.value(10)),
              ),
              child: DealerProductTypeTab(
                label: 'Add Product',
                isSelected: selectedTab == 0,
                isLeftTab: true,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => _confirmDemoProduct(context),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppResponsive.value(10)),
                bottomRight: Radius.circular(AppResponsive.value(10)),
              ),
              child: DealerProductTypeTab(
                label: 'Demo Product',
                isSelected: selectedTab == 1,
                isLeftTab: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDemoProduct(final BuildContext context) async {
    if (selectedTab == 1) return;

    await showModalBottomSheet<void>(
      context: context,
      builder: (final BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppResponsive.value(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Switch to Demo Product?'.tr, style: productFormTitle),
                Gap(AppResponsive.value(8)),
                Text(
                  'All entered details, selected photos, and reel will be removed.'
                      .tr,
                  style: companyProfileUploadDescription,
                ),
                Gap(AppResponsive.value(20)),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancel'.tr),
                      ),
                    ),
                    Gap(AppResponsive.value(12)),
                    Expanded(
                      child: FilledButton(
                        onPressed: () async {
                          await onDemoProductConfirmed();
                          if (context.mounted) Navigator.of(context).pop();
                        },
                        child: Text('Continue'.tr),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
