import 'package:flutter/material.dart';
import 'package:krishi_mart/data/model/notification_model.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class NotificationListRow extends StatelessWidget {
  const NotificationListRow({required this.notification, super.key});

  final PushNotificationModel notification;

  @override
  Widget build(final BuildContext context) {
    final bool isRead = notification.isRead ?? false;

    return Container(
      padding: EdgeInsets.all(AppResponsive.value(14)),
      decoration: BoxDecoration(
        color: isRead ? AppColors.white : AppColors.homeSurface,
        borderRadius: BorderRadius.circular(AppResponsive.value(14)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: AppResponsive.value(38),
            height: AppResponsive.value(38),
            decoration: BoxDecoration(
              color: AppColors.homeChip,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.themeColor,
            ),
          ),
          SizedBox(width: AppResponsive.value(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  notification.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.homeProductCompany,
                ),
                SizedBox(height: AppResponsive.value(4)),
                Text(
                  notification.message ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.homeBody,
                ),
              ],
            ),
          ),
          if (!isRead)
            Container(
              width: AppResponsive.value(8),
              height: AppResponsive.value(8),
              margin: EdgeInsets.only(left: AppResponsive.value(8)),
              decoration: const BoxDecoration(
                color: AppColors.color1F6D1A,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
