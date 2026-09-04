import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class CompanyCertificatePreview extends StatelessWidget {
  const CompanyCertificatePreview({
    required this.certificatePath,
    required this.onRemove,
    super.key,
  });

  final String certificatePath;
  final VoidCallback onRemove;

  @override
  Widget build(final BuildContext context) {
    final String fileName = certificatePath.split(Platform.pathSeparator).last;
    final String extension = fileName.split('.').last.toLowerCase();
    final bool isImage = <String>[
      'jpg',
      'jpeg',
      'png',
      'webp',
    ].contains(extension);
    final bool isPdf = extension == 'pdf';

    return Container(
      padding: EdgeInsets.all(AppResponsive.value(10, tablet: 12)),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.formBorder),
        borderRadius: BorderRadius.circular(AppResponsive.value(10)),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(AppResponsive.value(6)),
            child: SizedBox(
              width: AppResponsive.value(52, tablet: 60),
              height: AppResponsive.value(52, tablet: 60),
              child: isImage
                  ? Image.file(File(certificatePath), fit: BoxFit.cover)
                  : Container(
                      color: AppColors.productImageBackground,
                      child: Icon(
                        isPdf
                            ? Icons.picture_as_pdf_outlined
                            : Icons.insert_drive_file_outlined,
                        color: AppColors.categorySelected,
                      ),
                    ),
            ),
          ),
          Gap(AppResponsive.value(10, tablet: 12)),
          Expanded(
            child: Text(
              fileName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: companyProfileUploadDescription,
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: Icon(Icons.close, color: AppColors.roleDealer),
          ),
        ],
      ),
    );
  }
}
