import 'package:krishi_mart/data/model/user_company_module.dart';

class AuthModel {
  String? message;
  UserDetailModel? data;

  AuthModel({this.message, this.data});

  AuthModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? UserDetailModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserDetailModel {
  String? accessToken;
  String? tokenType;
  String? expiresAt;
  bool? hasProfileCompleted;
  String? profileStatus;
  User? user;

  UserDetailModel({
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.user,
    this.hasProfileCompleted,
    this.profileStatus,
  });

  UserDetailModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
    hasProfileCompleted = json['profile_completed'];
    profileStatus = json['profile_status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_at'] = expiresAt;
    data['profile_completed'] = hasProfileCompleted;
    data['profile_status'] = profileStatus;

    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
