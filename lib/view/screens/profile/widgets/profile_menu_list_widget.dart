import 'package:flutter/material.dart';
import 'package:krishi_mart/data/model/profile_menu_item.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/view/screens/profile/widgets/profile_menu_row.dart';

class ProfileMenuListWidget extends StatelessWidget {
  const ProfileMenuListWidget({
    required this.items,
    required this.onItemTap,
    super.key,
  });

  final List<ProfileMenuItem> items;
  final ValueChanged<ProfileMenuItem> onItemTap;

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppResponsive.value(18)),
        border: Border.all(color: AppColors.formBorder),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (final BuildContext context, final int index) =>
            const Divider(height: 1, indent: 70, color: AppColors.formBorder),
        itemBuilder: (final BuildContext context, final int index) {
          final ProfileMenuItem item = items[index];
          return ProfileMenuRow(item: item, onTap: () => onItemTap(item));
        },
      ),
    );
  }
}
