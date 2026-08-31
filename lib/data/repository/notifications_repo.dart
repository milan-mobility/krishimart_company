import 'package:dio/dio.dart';
import 'package:krishi_mart/data/model/notification_model.dart';
import 'package:krishi_mart/data/network/api_end_points.dart';
import 'package:krishi_mart/data/network/dio_client.dart';

class NotificationsRepo {
  NotificationsRepo(this._dioClient);

  final DioClient _dioClient;

  Future<NotificationModel> getNotifications(final int page) async {
    final Response<dynamic> response = await _dioClient.get(
      Endpoints.notifications,
      queryParameters: <String, int>{'page': page, 'per_page': 10},
    );
    return NotificationModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<bool> markNotificationAsRead(final String notificationId) async {
    final Response<dynamic> response = await _dioClient.post(
      Endpoints.readNotification,
      data: <String, String>{'notification_id': notificationId},
    );
    return response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204;
  }
}
