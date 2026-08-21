class ProductModel {
  String? message;
  ProductDataModel? data;

  ProductModel({this.message, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? ProductDataModel.fromJson(json['data'])
        : null;
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

class ProductDataModel {
  int? currentPage;
  List<Product>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ProductDataModel({
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

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Product {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? companyId;
  int? dealerId;
  int? brandId;
  int? categoryId;
  int? cropId;
  String? name;
  String? slug;
  String? sku;
  String? shortDescription;
  String? description;
  String? dose;
  String? reelVideo;
  String? reelUrl;
  String? price;
  String? mrp;
  String? unit;
  int? views;
  String? status;
  bool? featured;
  String? publishedAt;
  String? deletedAt;
  int? createdBy;
  String? reelVideoUrl;
  Brand? brand;
  Brand? category;
  Brand? crop;
  PrimaryImage? primaryImage;
  String? demoFarmerName;
  int? talukaId;
  int? villageId;
  bool? isDemo;
  String? youtubeVideoLink;
  Company? company;
  List<Crops>? crops;

  Product({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.companyId,
    this.dealerId,
    this.brandId,
    this.categoryId,
    this.cropId,
    this.name,
    this.slug,
    this.sku,
    this.shortDescription,
    this.description,
    this.dose,
    this.reelVideo,
    this.reelUrl,
    this.price,
    this.mrp,
    this.unit,
    this.views,
    this.status,
    this.featured,
    this.publishedAt,
    this.deletedAt,
    this.createdBy,
    this.reelVideoUrl,
    this.brand,
    this.category,
    this.crop,
    this.primaryImage,
    this.demoFarmerName,
    this.talukaId,
    this.villageId,
    this.isDemo,
    this.youtubeVideoLink,
    this.company,
    this.crops,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    companyId = json['company_id'];
    dealerId = json['dealer_id'];
    brandId = json['brand_id'];
    categoryId = json['category_id'];
    cropId = json['crop_id'];
    name = json['name'];
    slug = json['slug'];
    sku = json['sku'];
    shortDescription = json['short_description'];
    description = json['description'];
    dose = json['dose'];
    reelVideo = json['reel_video'];
    reelUrl = json['reel_url'];
    price = json['price'];
    mrp = json['mrp'];
    unit = json['unit'];
    views = json['views'];
    status = json['status'];
    featured = json['featured'];
    publishedAt = json['published_at'];
    deletedAt = json['deleted_at'];
    createdBy = json['created_by'];
    reelVideoUrl = json['reel_video_url'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    category = json['category'] != null
        ? Brand.fromJson(json['category'])
        : null;
    crop = json['crop'] != null ? Brand.fromJson(json['crop']) : null;
    primaryImage = json['images'] != null
        ? PrimaryImage.fromJson(json['primary_image'])
        : null;
    demoFarmerName = json['demo_farmer_name'];
    talukaId = json['taluka_id'];
    villageId = json['village_id'];
    isDemo = json['is_demo'];
    youtubeVideoLink = json['youtube_video_link'];
    company = json['company'] != null
        ? new Company.fromJson(json['company'])
        : null;
    if (json['crops'] != null) {
      crops = <Crops>[];
      json['crops'].forEach((v) {
        crops!.add(new Crops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['company_id'] = companyId;
    data['dealer_id'] = dealerId;
    data['brand_id'] = brandId;
    data['category_id'] = categoryId;
    data['crop_id'] = cropId;
    data['name'] = name;
    data['slug'] = slug;
    data['sku'] = sku;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['dose'] = dose;
    data['reel_video'] = reelVideo;
    data['reel_url'] = reelUrl;
    data['price'] = price;
    data['mrp'] = mrp;
    data['unit'] = unit;
    data['views'] = views;
    data['status'] = status;
    data['featured'] = featured;
    data['published_at'] = publishedAt;
    data['deleted_at'] = deletedAt;
    data['created_by'] = createdBy;
    data['reel_video_url'] = reelVideoUrl;
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (crop != null) {
      data['crop'] = crop!.toJson();
    }
    if (primaryImage != null) {
      data['images'] = primaryImage!.toJson();
    }
    data['youtube_video_link'] = youtubeVideoLink;
    if (primaryImage != null) {
      data['primary_image'] = primaryImage!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (crops != null) {
      data['crops'] = crops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Company {
  int? id;
  String? companyName;

  Company({this.id, this.companyName});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['company_name'] = companyName;
    return data;
  }
}

class Crops {
  int? id;
  String? name;
  Pivot? pivot;

  Crops({this.id, this.name, this.pivot});

  Crops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? productId;
  int? cropId;
  String? createdAt;
  String? updatedAt;

  Pivot({this.productId, this.cropId, this.createdAt, this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    cropId = json['crop_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = productId;
    data['crop_id'] = cropId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Brand {
  int? id;
  String? name;

  Brand({this.id, this.name});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class PrimaryImage {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? productId;
  String? image;
  bool? isPrimary;
  int? sortOrder;
  String? imageUrl;

  PrimaryImage({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.productId,
    this.image,
    this.isPrimary,
    this.sortOrder,
    this.imageUrl,
  });

  PrimaryImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productId = json['product_id'];
    image = json['image'];
    isPrimary = json['is_primary'];
    sortOrder = json['sort_order'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['product_id'] = productId;
    data['image'] = image;
    data['is_primary'] = isPrimary;
    data['sort_order'] = sortOrder;
    data['image_url'] = imageUrl;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  int? page;
  bool? active;

  Links({this.url, this.label, this.page, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    page = json['page'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['page'] = page;
    data['active'] = active;
    return data;
  }
}
