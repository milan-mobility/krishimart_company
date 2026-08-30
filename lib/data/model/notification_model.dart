class NotificationModel {
  NotificationModel({this.message, this.data});

  factory NotificationModel.fromJson(final Map<String, dynamic> json) {
    final dynamic pageData = json['data'];
    return NotificationModel(
      message: json['message'] as String?,
      data: pageData is Map<String, dynamic>
          ? NotificationPageData.fromJson(pageData)
          : null,
    );
  }

  final String? message;
  final NotificationPageData? data;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'message': message,
    'data': data?.toJson(),
  };
}

class NotificationPageData {
  NotificationPageData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory NotificationPageData.fromJson(final Map<String, dynamic> json) {
    final dynamic notifications = json['data'];
    final dynamic paginationLinks = json['links'];
    return NotificationPageData(
      currentPage: json['current_page'] as int?,
      data: notifications is List<dynamic>
          ? notifications
                .whereType<Map<String, dynamic>>()
                .map(PushNotificationModel.fromJson)
                .toList()
          : <PushNotificationModel>[],
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      lastPageUrl: json['last_page_url'] as String?,
      links: paginationLinks is List<dynamic>
          ? paginationLinks
                .whereType<Map<String, dynamic>>()
                .map(Links.fromJson)
                .toList()
          : <Links>[],
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      prevPageUrl: json['prev_page_url'] as String?,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );
  }

  final int? currentPage;
  final List<PushNotificationModel>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Links>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'current_page': currentPage,
    'data': data?.map((final PushNotificationModel item) => item.toJson()),
    'first_page_url': firstPageUrl,
    'from': from,
    'last_page': lastPage,
    'last_page_url': lastPageUrl,
    'links': links?.map((final Links item) => item.toJson()),
    'next_page_url': nextPageUrl,
    'path': path,
    'per_page': perPage,
    'prev_page_url': prevPageUrl,
    'to': to,
    'total': total,
  };
}

class PushNotificationModel {
  PushNotificationModel({
    this.id,
    this.title,
    this.message,
    this.isRead,
    this.readAt,
    this.createdAt,
  });

  factory PushNotificationModel.fromJson(final Map<String, dynamic> json) {
    return PushNotificationModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      isRead: json['is_read'] as bool?,
      readAt: json['read_at'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  final String? id;
  final String? title;
  final String? message;
  final bool? isRead;
  final String? readAt;
  final String? createdAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'message': message,
    'is_read': isRead,
    'read_at': readAt,
    'created_at': createdAt,
  };
}

class Links {
  Links({this.url, this.label, this.page, this.active});

  factory Links.fromJson(final Map<String, dynamic> json) {
    return Links(
      url: json['url'] as String?,
      label: json['label'] as String?,
      page: json['page'] as int?,
      active: json['active'] as bool?,
    );
  }

  final String? url;
  final String? label;
  final int? page;
  final bool? active;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'url': url,
    'label': label,
    'page': page,
    'active': active,
  };
}
