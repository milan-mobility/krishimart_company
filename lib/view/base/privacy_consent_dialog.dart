import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/routes/route_helper.dart';

const String _privacyPolicyUrl =
    'https://oneupapps.oneupitsolution.com/onegameplus/privacy-policy.html';

const String _termsAndConditions =
    'https://oneupapps.oneupitsolution.com/onegameplus/terms-of-use.html';

Future<T?> showPrivacyConsentDialog<T>({required VoidCallback onAccepted}) {
  return Get.dialog<T>(
    PrivacyConsentDialog(onAccepted: onAccepted),
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: 0.72),
  );
}

class PrivacyConsentDialog extends StatelessWidget {
  const PrivacyConsentDialog({super.key, required this.onAccepted});

  final VoidCallback onAccepted;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: AppResponsive.space(18)),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: AppResponsive.value(340, tablet: 420, largeTablet: 460),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.space(18),
          vertical: AppResponsive.space(20),
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppResponsive.value(16)),
          border: Border.all(
            color: AppColors.themeColor.withValues(alpha: 0.9),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.28),
              blurRadius: 28,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Your Privacy is Important'.tr,
              style: interW700.copyWith(
                fontSize: AppResponsive.font(16),
                height: 1.2,
                color: AppColors.themeColor,
              ),
            ),
            Gap(AppResponsive.space(6)),
            Container(
              width: double.infinity,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.color414844,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            Gap(AppResponsive.space(22)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppResponsive.space(6)),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'To Start using this app, please read and\naccept our Terms of Service\nand Privacy Policy.'
                      .tr,
                  textAlign: TextAlign.center,
                  style: interW500.copyWith(
                    fontSize: AppResponsive.font(14),
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            Gap(AppResponsive.space(22)),
            Row(
              children: <Widget>[
                Expanded(
                  child: _DialogActionButton(
                    label: 'Privacy Policy'.tr,
                    onTap: () => _openDocument(
                      title: 'Privacy Policy'.tr,
                      url: _privacyPolicyUrl,
                    ),
                  ),
                ),
                Gap(AppResponsive.space(12)),
                Expanded(
                  child: _DialogActionButton(
                    label: 'Terms & Condition'.tr,
                    onTap: () => _openDocument(
                      title: 'Terms of service'.tr,
                      url: _termsAndConditions,
                    ),
                  ),
                ),
              ],
            ),
            Gap(AppResponsive.space(20)),
            _AcceptButton(
              onTap: () {
                Get.back<void>();
                onAccepted();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openDocument({required String title, required String url}) {
    Get.toNamed(
      RouteHelper.commonWebView,
      arguments: <String, String>{'title': title, 'url': url},
    );
  }
}

class _DialogActionButton extends StatelessWidget {
  const _DialogActionButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppResponsive.value(38, tablet: 44),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppResponsive.value(9)),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.homeBannerStart.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(AppResponsive.value(9)),
            ),
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: interW500.copyWith(
                  fontSize: AppResponsive.font(12.5),
                  color: AppColors.white.withValues(alpha: 0.85),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AcceptButton extends StatelessWidget {
  const _AcceptButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppResponsive.value(40, tablet: 48),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.color1F6D1A,
          borderRadius: BorderRadius.circular(AppResponsive.value(8)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppResponsive.value(8)),
            onTap: onTap,
            child: Center(
              child: Text(
                'Accept & Continue'.tr,
                style: interW600.copyWith(
                  fontSize: AppResponsive.font(15),
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
