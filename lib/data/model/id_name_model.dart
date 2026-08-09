class IdNameModel {
  String? message;
  List<IdName>? data;

  IdNameModel({this.message, this.data});

  IdNameModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <IdName>[];
      json['data'].forEach((v) {
        data!.add(IdName.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IdName {
  int? id;
  int? districtId;
  String? name;
  String? code;

  IdName({this.id, this.districtId, this.name, this.code});

  IdName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['district_id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['district_id'] = districtId;
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}
