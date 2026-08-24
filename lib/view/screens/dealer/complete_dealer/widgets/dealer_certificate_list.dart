import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class DealerCertificateList extends StatelessWidget {
  const DealerCertificateList({
    required this.certificatePaths,
    required this.onRemove,
    super.key,
  });

  final List<String> certificatePaths;
  final ValueChanged<int> onRemove;

  @override
  Widget build(final BuildContext context) {
    if (certificatePaths.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Selected Certificates'.tr, style: companyProfileFieldLabel),
        Gap(AppResponsive.value(8, tablet: 10)),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: certificatePaths.length,
          separatorBuilder: (_, _) => Gap(AppResponsive.value(8, tablet: 10)),
          itemBuilder: (final BuildContext context, final int index) {
            final String certificatePath = certificatePaths[index];
            final String fileName = certificatePath
                .split(Platform.pathSeparator)
                .last;
            final bool isPdf = fileName.toLowerCase().endsWith('.pdf');

            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.value(12, tablet: 14),
                vertical: AppResponsive.value(10, tablet: 12),
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.formBorder),
                borderRadius: BorderRadius.circular(AppResponsive.value(8)),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    isPdf
                        ? Icons.picture_as_pdf_outlined
                        : Icons.image_outlined,
                    color: AppColors.categorySelected,
                  ),
                  Gap(AppResponsive.value(10, tablet: 12)),
                  Expanded(
                    child: Text(
                      fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: companyProfileUploadDescription,
                    ),
                  ),
                  IconButton(
                    onPressed: () => onRemove(index),
                    tooltip: 'Remove certificate'.tr,
                    icon: Icon(Icons.close, color: AppColors.roleDealer),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
