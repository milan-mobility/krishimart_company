import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krishi_mart/data/model/notification_model.dart';
import 'package:krishi_mart/data/repository/notifications_repo.dart';

class NotificationController extends GetxController {
  NotificationController(this._notificationsRepo);

  final NotificationsRepo _notificationsRepo;
  late final PagingController<int, PushNotificationModel> pagingController;
  bool _hasNextPage = true;
  int unreadCount = 0;

  @override
  void onInit() {
    super.onInit();
    pagingController = PagingController<int, PushNotificationModel>(
      getNextPageKey: (final PagingState<int, PushNotificationModel> state) =>
          _hasNextPage ? state.nextIntPageKey : null,
      fetchPage: _fetchNotificationsPage,
    );
    pagingController.fetchNextPage();
  }

  Future<List<PushNotificationModel>> _fetchNotificationsPage(
    final int pageKey,
  ) async {
    if (pageKey == 1) _hasNextPage = true;

    try {
      final NotificationModel response = await _notificationsRepo
          .getNotifications(pageKey);
      _hasNextPage = response.data?.nextPageUrl != null;
      final List<PushNotificationModel> notifications =
          response.data?.data ?? <PushNotificationModel>[];
      if (pageKey == 1) {
        unreadCount =
            response.unreadCount ??
            response.data?.unreadCount ??
            notifications.where((final PushNotificationModel item) {
              return !(item.isRead ?? false);
            }).length;
        update();
      }
      return notifications;
    } on DioException {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> refreshNotifications() async {
    _hasNextPage = true;
    pagingController
      ..refresh()
      ..fetchNextPage();
  }

  Future<void> markNotificationAsRead(
    final PushNotificationModel notification,
  ) async {
    if (notification.isRead ?? false) {
      return;
    }
    await markNotificationAsReadById(notification.id);
  }

  Future<void> markNotificationAsReadById(final String? notificationId) async {
    if (notificationId == null || notificationId.isEmpty) {
      return;
    }
    try {
      final bool isMarked = await _notificationsRepo.markNotificationAsRead(
        notificationId,
      );
      if (isMarked) {
        await refreshNotifications();
      }
    } on DioException catch (error) {
      debugPrint('Mark notification as read failed: $error');
    } catch (error) {
      debugPrint('Mark notification as read failed: $error');
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
