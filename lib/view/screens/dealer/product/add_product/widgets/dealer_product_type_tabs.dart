import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/view/base/confirmation_bottom_sheet.dart';
import 'package:krishi_mart/view/screens/dealer/product/add_product/widgets/dealer_product_type_tab.dart';

class DealerProductTypeTabs extends StatelessWidget {
  const DealerProductTypeTabs({
    required this.selectedTab,
    required this.hasEnteredProductData,
    required this.onProductTypeSelected,
    super.key,
  });

  final int selectedTab;
  final bool hasEnteredProductData;
  final Future<void> Function(int productTab) onProductTypeSelected;

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
              onTap: () => _selectProductType(context, 0),
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
              onTap: () => _selectProductType(context, 1),
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

  Future<void> _selectProductType(
    final BuildContext context,
    final int productTab,
  ) async {
    if (selectedTab == productTab) return;
    if (!hasEnteredProductData) {
      await onProductTypeSelected(productTab);
      return;
    }

    Get.bottomSheet(
      ConfirmationBottomSheet(
        title: 'Switch Product Type?'.tr,
        description:
            'All entered details, selected photos, and reel will be removed.'
                .tr,
        onPositive: () async {
          Get.back();
          await onProductTypeSelected(productTab);
        },
        txtPositive: 'Continue'.tr,
      ),
    );
  }
}
