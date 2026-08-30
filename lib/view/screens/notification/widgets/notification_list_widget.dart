import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krishi_mart/data/model/notification_model.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/view/screens/notification/widgets/notification_empty_widget.dart';
import 'package:krishi_mart/view/screens/notification/widgets/notification_error_widget.dart';
import 'package:krishi_mart/view/screens/notification/widgets/notification_list_row.dart';

class NotificationListWidget extends StatelessWidget {
  const NotificationListWidget({
    required this.pagingController,
    required this.onRefresh,
    super.key,
  });

  final PagingController<int, PushNotificationModel> pagingController;
  final Future<void> Function() onRefresh;

  @override
  Widget build(final BuildContext context) {
    return PagingListener<int, PushNotificationModel>(
      controller: pagingController,
      builder:
          (
            final BuildContext context,
            final PagingState<int, PushNotificationModel> state,
            final VoidCallback fetchNextPage,
          ) => RefreshIndicator(
            onRefresh: onRefresh,
            child: PagedListView<int, PushNotificationModel>.separated(
              padding: EdgeInsets.all(AppResponsive.value(16)),
              state: state,
              fetchNextPage: fetchNextPage,
              separatorBuilder: (_, _) =>
                  SizedBox(height: AppResponsive.value(10)),
              builderDelegate: PagedChildBuilderDelegate<PushNotificationModel>(
                itemBuilder:
                    (
                      final BuildContext context,
                      final PushNotificationModel notification,
                      final int index,
                    ) => NotificationListRow(notification: notification),
                firstPageProgressIndicatorBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                newPageProgressIndicatorBuilder: (_) => const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                ),
                noItemsFoundIndicatorBuilder: (_) =>
                    const NotificationEmptyWidget(),
                firstPageErrorIndicatorBuilder: (_) => NotificationErrorWidget(
                  onRetry: pagingController.fetchNextPage,
                ),
                newPageErrorIndicatorBuilder: (_) => NotificationErrorWidget(
                  onRetry: pagingController.fetchNextPage,
                ),
              ),
            ),
          ),
    );
  }
}
