class NotificationModel {
  bool? status;
  List<Notifications>? notifications;

  NotificationModel({this.status, this.notifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? notifyId;
  String? userType;
  int? userId;
  String? notifyTitle;
  String? notifyDetails;
  String? notifyType;
  String? status;
  String? createdAt;
  String? updatedAt;
  NotifyData? notifyData;

  Notifications({
    this.notifyId,
    this.userType,
    this.userId,
    this.notifyTitle,
    this.notifyDetails,
    this.notifyType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.notifyData,
  });

  Notifications.fromJson(Map<String, dynamic> json) {
    notifyId = _toInt(
      json['notify_id'] ?? json['notification_id'] ?? json['id'],
    );
    userType = json['user_type'];
    userId = json['user_id'];
    notifyTitle = json['notify_title'];
    notifyDetails = json['notify_details'];
    notifyType = json['notify_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notifyData = json['notify_data'] != null
        ? NotifyData.fromJson(json['notify_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notify_id'] = notifyId;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['notify_title'] = notifyTitle;
    data['notify_details'] = notifyDetails;
    data['notify_type'] = notifyType;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (notifyData != null) {
      data['notify_data'] = notifyData!.toJson();
    }
    return data;
  }

  static int? _toInt(final dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }
}

class NotifyData {
  String? appointmentTime;
  String? type;
  int? appointmentId;

  NotifyData({this.appointmentTime, this.type});

  NotifyData.fromJson(Map<String, dynamic> json) {
    appointmentTime = json['appointment_time'];
    type = json['type'];
    appointmentId = json['appointment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointment_time'] = appointmentTime;
    data['type'] = type;
    data['appointment_id'] = appointmentId;
    return data;
  }
}

/// The data payload sent with an FCM notification.
class PushNotificationModel {
  const PushNotificationModel({
    this.notificationId,
    this.appointmentTime,
    this.appointmentId,
    this.body,
    this.type,
    this.title,
  });

  /// Server notification ID (`notify_id`). This is required to mark a push
  /// notification as read when it is opened outside the notification list.
  final int? notificationId;
  final String? appointmentTime;
  final int? appointmentId;
  final String? body;
  final String? type;
  final String? title;

  factory PushNotificationModel.fromJson(final Map<String, dynamic> json) {
    return PushNotificationModel(
      notificationId: _toInt(json['notify_id']),
      appointmentTime: json['appointment_time']?.toString(),
      appointmentId: _toInt(json['appointment_id']),
      body: json['body']?.toString(),
      type: json['type']?.toString(),
      title: json['title']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'notify_id': notificationId,
      'appointment_time': appointmentTime,
      'appointment_id': appointmentId,
      'body': body,
      'type': type,
      'title': title,
    };
  }

  static int? _toInt(final dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }
}
