import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/view/base/common_appbar.dart';
import 'package:krishi_mart/view/screens/notification/controller/notification_controller.dart';
import 'package:krishi_mart/view/screens/notification/widgets/notification_list_widget.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CommonAppbar(title: 'Notifications'.tr),
        body: SafeArea(
          child: NotificationListWidget(
            pagingController: controller.pagingController,
            onRefresh: controller.refreshNotifications,
          ),
        ),
      ),
    );
  }
}
