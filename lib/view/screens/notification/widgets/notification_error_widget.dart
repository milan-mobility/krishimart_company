import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/helpers/styles.dart';

class NotificationErrorWidget extends StatelessWidget {
  const NotificationErrorWidget({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Unable to load notifications'.tr, style: Styles.homeBody),
          TextButton(onPressed: onRetry, child: Text('Retry'.tr)),
        ],
      ),
    );
  }
}
