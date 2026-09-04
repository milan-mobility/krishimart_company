import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/view/base/common_appbar.dart';
import 'package:krishi_mart/view/screens/common_webview/controller/common_webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebview extends StatelessWidget {
  const CommonWebview({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: GetBuilder<CommonWebviewController>(
        init: CommonWebviewController(),
        builder: (final CommonWebviewController controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            extendBody: true,
            appBar: CommonAppbar(title: (controller.title ?? '').tr),
            body: SafeArea(
              child: Column(
                children: [
                  controller.progress < 1.0 && controller.progress > 0.0
                      ? SizedBox(
                          height: AppResponsive.space(4),
                          child: LinearProgressIndicator(
                            value: controller.progress,
                            backgroundColor: Colors.grey,
                            color: AppColors.themeColor,
                          ),
                        )
                      : const SizedBox.shrink(),
                  Expanded(
                    child: WebViewWidget(
                      controller: controller.webViewController,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
