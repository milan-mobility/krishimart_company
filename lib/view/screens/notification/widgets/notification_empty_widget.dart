import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/styles.dart';

class NotificationEmptyWidget extends StatelessWidget {
  const NotificationEmptyWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Text('Notifications not found!'.tr, style: Styles.homeBody),
    );
  }
}
