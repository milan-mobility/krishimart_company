class CommonModel {
  CommonModel({this.status, this.message});

  CommonModel.fromJson(final Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
  }
  bool? status;
  bool? success;
  String? message;
  int? registrationStep;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
