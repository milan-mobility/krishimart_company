class UserProfileModel {
  String? message;
  UserModel? data;

  UserProfileModel({this.message, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  Profile? profile;
  bool? profileCompleted;

  UserModel({this.user, this.profile, this.profileCompleted});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    profile = json['profile'] != null
        ? Profile.fromJson(json['profile'])
        : null;
    profileCompleted = json['profile_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    data['profile_completed'] = profileCompleted;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? status;
  String? role;
  bool? isVerified;
  String? profilePhotoUrl;

  User({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.status,
    this.isVerified,
    this.profilePhotoUrl,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    status = json['status'];
    isVerified = json['is_verified'];
    profilePhotoUrl = json['profile_photo_url'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['status'] = status;
    data['is_verified'] = isVerified;
    data['profile_photo_url'] = profilePhotoUrl;
    data['role'] = role;
    return data;
  }
}

class Profile {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? companyName;
  String? contactNumber;
  String? cinNumber;
  String? panNumber;
  String? gstNumber;
  String? website;
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
  State? state;
  District? district;
  String? licenseCertificateUrl;
  String? shopName;
  String? ownerName;
  Taluka? taluka;
  Village? village;
  List<String>? licenseDocumentUrls;
  int? villageId;
  int? talukaId;
  String? pesticideLicenseNumber;
  String? pesticideLicenseIssueDate;
  String? pesticideLicenseExpiryDate;
  String? fertilizerLicenseNumber;
  String? fertilizerLicenseIssueDate;
  String? fertilizerLicenseExpiryDate;
  String? seedsLicenseNumber;
  String? seedsLicenseIssueDate;
  String? seedsLicenseExpiryDate;
  List<String>? licenseDocuments;
  String? referralPersonName;
  String? referralMobile;

  Profile({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.companyName,
    this.contactNumber,
    this.cinNumber,
    this.panNumber,
    this.gstNumber,
    this.website,
    this.logo,
    this.shopName,
    this.ownerName,
    this.licenseCertificate,
    this.licenseStartDate,
    this.licenseEndDate,
    this.verificationStatus,
    this.stateId,
    this.districtId,
    this.address,
    this.addressLine2,
    this.postalCode,
    this.state,
    this.district,
    this.licenseCertificateUrl,
    this.pesticideLicenseNumber,
    this.pesticideLicenseIssueDate,
    this.pesticideLicenseExpiryDate,
    this.fertilizerLicenseNumber,
    this.fertilizerLicenseIssueDate,
    this.fertilizerLicenseExpiryDate,
    this.seedsLicenseNumber,
    this.seedsLicenseIssueDate,
    this.seedsLicenseExpiryDate,
    this.talukaId,
    this.villageId,
    this.taluka,
    this.village,
    this.licenseDocumentUrls,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    companyName = json['company_name'];
    contactNumber = json['contact_number'];
    cinNumber = json['cin_number'];
    panNumber = json['pan_number'];
    gstNumber = json['gst_number'];
    website = json['website'];
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
    shopName = json['shop_name'];
    ownerName = json['owner_name'];
    state = json['state'] != null ? State.fromJson(json['state']) : null;
    district = json['district'] != null
        ? District.fromJson(json['district'])
        : null;
    licenseCertificateUrl = json['license_certificate_url'];
    pesticideLicenseNumber = json['pesticide_license_number'];
    pesticideLicenseIssueDate = json['pesticide_license_issue_date'];
    pesticideLicenseExpiryDate = json['pesticide_license_expiry_date'];
    fertilizerLicenseNumber = json['fertilizer_license_number'];
    fertilizerLicenseIssueDate = json['fertilizer_license_issue_date'];
    fertilizerLicenseExpiryDate = json['fertilizer_license_expiry_date'];
    seedsLicenseNumber = json['seeds_license_number'];
    seedsLicenseIssueDate = json['seeds_license_issue_date'];
    seedsLicenseExpiryDate = json['seeds_license_expiry_date'];
    licenseDocuments = json['license_documents'].cast<String>();
    taluka = json['taluka'] != null ? Taluka.fromJson(json['taluka']) : null;
    village = json['village'] != null
        ? Village.fromJson(json['village'])
        : null;
    licenseDocumentUrls = json['license_document_urls'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_id'] = userId;
    data['company_name'] = companyName;
    data['contact_number'] = contactNumber;
    data['cin_number'] = cinNumber;
    data['pan_number'] = panNumber;
    data['gst_number'] = gstNumber;
    data['website'] = website;
    data['logo'] = logo;
    data['shop_name'] = shopName;
    data['owner_name'] = ownerName;
    data['license_certificate'] = licenseCertificate;
    data['license_start_date'] = licenseStartDate;
    data['license_end_date'] = licenseEndDate;
    data['verification_status'] = verificationStatus;
    data['state_id'] = stateId;
    data['district_id'] = districtId;
    data['address'] = address;
    data['address_line_2'] = addressLine2;
    data['postal_code'] = postalCode;
    if (state != null) {
      data['state'] = state!.toJson();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    data['license_certificate_url'] = licenseCertificateUrl;
    data['pesticide_license_number'] = pesticideLicenseNumber;
    data['pesticide_license_issue_date'] = pesticideLicenseIssueDate;
    data['pesticide_license_expiry_date'] = pesticideLicenseExpiryDate;
    data['fertilizer_license_number'] = fertilizerLicenseNumber;
    data['fertilizer_license_issue_date'] = fertilizerLicenseIssueDate;
    data['fertilizer_license_expiry_date'] = fertilizerLicenseExpiryDate;
    data['seeds_license_number'] = seedsLicenseNumber;
    data['seeds_license_issue_date'] = seedsLicenseIssueDate;
    data['seeds_license_expiry_date'] = seedsLicenseExpiryDate;
    data['license_documents'] = licenseDocuments;
    if (taluka != null) {
      data['taluka'] = taluka!.toJson();
    }
    if (village != null) {
      data['village'] = village!.toJson();
    }
    data['license_document_urls'] = licenseDocumentUrls;
    return data;
  }
}

class State {
  int? id;
  String? name;
  String? code;
  String? createdAt;
  String? updatedAt;
  int? status;

  State({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    return data;
  }
}

class District {
  int? id;
  int? stateId;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? code;
  int? status;

  District({
    this.id,
    this.stateId,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.code,
    this.status,
  });

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateId = json['state_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['state_id'] = stateId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['code'] = code;
    data['status'] = status;
    return data;
  }
}

class Taluka {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? districtId;
  String? name;
  String? code;
  int? status;

  Taluka({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.districtId,
    this.name,
    this.code,
    this.status,
  });

  Taluka.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    districtId = json['district_id'];
    name = json['name'];
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['district_id'] = districtId;
    data['name'] = name;
    data['code'] = code;
    data['status'] = status;
    return data;
  }
}

class Village {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? talukaId;
  String? name;
  String? code;
  int? status;

  Village({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.talukaId,
    this.name,
    this.code,
    this.status,
  });

  Village.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    talukaId = json['taluka_id'];
    name = json['name'];
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['taluka_id'] = talukaId;
    data['name'] = name;
    data['code'] = code;
    data['status'] = status;
    return data;
  }
}
