import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/network/api_end_points.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class DealerExistingLicenseList extends StatelessWidget {
  const DealerExistingLicenseList({required this.documentUrls, super.key});

  final List<String> documentUrls;

  @override
  Widget build(final BuildContext context) {
    if (documentUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Uploaded Licenses'.tr, style: companyProfileFieldLabel),
        Gap(AppResponsive.value(8, tablet: 10)),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: documentUrls.length,
          separatorBuilder: (_, _) => Gap(AppResponsive.value(8, tablet: 10)),
          itemBuilder: (final BuildContext context, final int index) {
            final String documentUrl = documentUrls[index];
            final Uri? uri = Uri.tryParse(documentUrl);
            final String fileName = uri?.pathSegments.lastOrNull ?? documentUrl;
            final bool isPdf =
                uri?.path.toLowerCase().endsWith('.pdf') ?? false;
            final String resolvedUrl = documentUrl.startsWith('http')
                ? documentUrl
                : '${Endpoints.imageUrl}$documentUrl';

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
                  SizedBox(
                    width: AppResponsive.value(42, tablet: 48),
                    height: AppResponsive.value(42, tablet: 48),
                    child: isPdf
                        ? Icon(
                            Icons.picture_as_pdf_outlined,
                            color: AppColors.categorySelected,
                          )
                        : CachedNetworkImage(
                            imageUrl: resolvedUrl,
                            fit: BoxFit.cover,
                            placeholder: (_, _) => const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                            errorWidget: (_, _, _) => Icon(
                              Icons.image_outlined,
                              color: AppColors.categorySelected,
                            ),
                          ),
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
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
