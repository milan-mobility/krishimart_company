class Endpoints {
  static const String liveUrl = 'https://app.advick.space/';

  static const String baseUrl = liveUrl;

  static const String api = 'api/v1/';

  static const String imageUrl = '${baseUrl}storage/';

  //Auth
  static const String sendOTP = '${api}auth/otp/send';
  static const String verifyOTP = '${api}auth/otp/verify';
  static const String resendOTP = '${api}auth/otp/resend';
  static const String deleteAccount = '${api}me/account';

  //Farmer
  static const String farmerProfile = '${api}farmer/profile';

  //Company
  static const String createCompanyProfile = '${api}company/profile';
  static const String getCompanyProfile = '${api}company/profile';
  static const String createProduct = '${api}company/products';
  static const String productList = '${api}company/products';
  static const String notifications = '${api}notifications';
  static const String readNotification = '${api}notifications/read';

  static String getDashboard(final String role) {
    return '$api$role/dashboard';
  }

  static String getBanners(final String role) {
    return '${api}banners?audience=$role';
  }

  static String deleteProduct(final int productId) {
    return '${api}company/products/$productId';
  }

  static String updateCompanyProduct(final int productId) {
    return '${api}company/products/$productId';
  }

  static String deleteProductImage({
    required final String role,
    required final int productId,
    required final int imageId,
  }) {
    return '$api$role/products/$productId/images/$imageId';
  }

  static String deleteProductReel({required final int productId}) {
    return '${api}products/$productId/reel';
  }

  //Dealer
  static const String saveDealerProfile = '${api}dealer/profile';
  static const String getDealerData = '${api}dealer/profile';
  static const String dealerProductList = '${api}dealer/products';
  static const String createDealerProduct = '${api}dealer/products';
  static const String demoProducts = '${api}dealer/demo-products';
  static String deleteDealerProduct(final int productId) {
    return '${api}dealer/products/$productId';
  }

  static String updateDealerProduct(final int productId) {
    return '${api}dealer/products/$productId';
  }

  //Common
  static const String getStates = '${api}masters/states';

  static String getDistricts(final int stateId) {
    return '${api}masters/states/$stateId/districts';
  }

  static String getTalukas(final int districtId) {
    return '${api}masters/districts/$districtId/talukas';
  }

  static String getVillages(final int talukaId) {
    return '${api}masters/talukas/$talukaId/villages';
  }

  static const String categories = '${api}categories';
  static const String crops = '${api}masters/crops';

  static const String termsAndConditions = '${baseUrl}terms-of-use.html';
  static const String privacyPolicy = '${baseUrl}privacy-policy.html';
}
