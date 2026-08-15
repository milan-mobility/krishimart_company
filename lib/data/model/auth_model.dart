class AuthModel {
  String? message;
  UserModel? data;

  AuthModel({this.message, this.data});

  AuthModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
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

class UserModel {
  String? accessToken;
  String? tokenType;
  String? expiresAt;
  bool? hasProfileCompleted;
  String? profileStatus;
  User? user;

  UserModel({
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.user,
    this.profileStatus,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
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

class User {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? role;

  User({this.id, this.name, this.mobile, this.email, this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}
