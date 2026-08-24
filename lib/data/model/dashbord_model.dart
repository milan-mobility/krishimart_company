import 'package:krishi_mart/data/model/product_model.dart';

class DashboardModel {
  String? message;
  Dashboard? data;

  DashboardModel({this.message, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Dashboard.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Dashboard {
  Company? company;
  int? totalProducts;
  int? totalViews;
  int? activeProducts;
  int? pendingProducts;
  List<Product>? recentProducts;

  Dashboard({
    this.company,
    this.totalProducts,
    this.totalViews,
    this.activeProducts,
    this.pendingProducts,
    this.recentProducts,
  });

  Dashboard.fromJson(Map<String, dynamic> json) {
    company = json['company'] != null
        ? new Company.fromJson(json['company'])
        : null;
    totalProducts = json['total_products'];
    totalViews = json['total_views'];
    activeProducts = json['active_products'];
    pendingProducts = json['pending_products'];
    if (json['recent_products'] != null) {
      recentProducts = <Product>[];
      json['recent_products'].forEach((v) {
        recentProducts!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['total_products'] = this.totalProducts;
    data['total_views'] = this.totalViews;
    data['active_products'] = this.activeProducts;
    data['pending_products'] = this.pendingProducts;
    if (this.recentProducts != null) {
      data['recent_products'] = this.recentProducts!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class Company {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? companyName;
  String? contactNumber;
  String? cinNumber;
  String? panNumber;
  String? licenseNumber;
  String? tanNumber;
  String? gstNumber;
  String? businessCategory;
  List<String>? businessCategoryIds;
  String? logo;
  String? licenseCertificate;
  String? licenseStartDate;
  String? licenseEndDate;
  String? verificationStatus;
  int? stateId;
  int? districtId;
  String? address;
  String? addressLine2;
  String? postalCode;

  Company({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.companyName,
    this.contactNumber,
    this.cinNumber,
    this.panNumber,
    this.licenseNumber,
    this.tanNumber,
    this.gstNumber,
    this.businessCategory,
    this.businessCategoryIds,
    this.logo,
    this.licenseCertificate,
    this.licenseStartDate,
    this.licenseEndDate,
    this.verificationStatus,
    this.stateId,
    this.districtId,
    this.address,
    this.addressLine2,
    this.postalCode,
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    companyName = json['company_name'];
    contactNumber = json['contact_number'];
    cinNumber = json['cin_number'];
    panNumber = json['pan_number'];
    licenseNumber = json['license_number'];
    tanNumber = json['tan_number'];
    gstNumber = json['gst_number'];
    businessCategory = json['business_category'];
    businessCategoryIds = json['business_category_ids'].cast<String>();
    logo = json['logo'];
    licenseCertificate = json['license_certificate'];
    licenseStartDate = json['license_start_date'];
    licenseEndDate = json['license_end_date'];
    verificationStatus = json['verification_status'];
    stateId = json['state_id'];
    districtId = json['district_id'];
    address = json['address'];
    addressLine2 = json['address_line_2'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['company_name'] = this.companyName;
    data['contact_number'] = this.contactNumber;
    data['cin_number'] = this.cinNumber;
    data['pan_number'] = this.panNumber;
    data['license_number'] = this.licenseNumber;
    data['tan_number'] = this.tanNumber;
    data['gst_number'] = this.gstNumber;
    data['business_category'] = this.businessCategory;
    data['business_category_ids'] = this.businessCategoryIds;
    data['logo'] = this.logo;
    data['license_certificate'] = this.licenseCertificate;
    data['license_start_date'] = this.licenseStartDate;
    data['license_end_date'] = this.licenseEndDate;
    data['verification_status'] = this.verificationStatus;
    data['state_id'] = this.stateId;
    data['district_id'] = this.districtId;
    data['address'] = this.address;
    data['address_line_2'] = this.addressLine2;
    data['postal_code'] = this.postalCode;
    return data;
  }
}
