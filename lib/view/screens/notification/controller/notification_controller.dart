import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krishi_mart/data/model/notification_model.dart';
import 'package:krishi_mart/data/repository/notifications_repo.dart';

class NotificationController extends GetxController {
  NotificationController(this._notificationsRepo);

  final NotificationsRepo _notificationsRepo;
  late final PagingController<int, PushNotificationModel> pagingController;
  bool _hasNextPage = true;

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
      return response.data?.data ?? <PushNotificationModel>[];
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

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
