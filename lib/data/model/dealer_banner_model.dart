class DealerBannerModel {
  String? message;
  List<Banner>? data;

  DealerBannerModel({this.message, this.data});

  DealerBannerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Banner>[];
      json['data'].forEach((v) {
        data!.add(Banner.fromJson(v));
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

class Banner {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? audience;
  int? createdBy;
  String? imageUrl;

  Banner({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.audience,
    this.createdBy,
    this.imageUrl,
  });

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    audience = json['audience'];
    createdBy = json['created_by'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image'] = image;
    data['audience'] = audience;
    data['created_by'] = createdBy;
    data['image_url'] = imageUrl;
    return data;
  }
}
