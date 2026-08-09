class Endpoints {
  static const String liveUrl = 'https://app.advick.space/';

  static const String baseUrl = liveUrl;

  static const String api = 'api/v1/';

  static const String sendOTP = '${api}auth/otp/send';
  static const String verifyOTP = '${api}auth/otp/verify';
  static const String farmerProfile = '${api}farmer/profile';
  static const String getDistricts = '${api}masters/districts';

  static String getTalukas(final int districtId) {
    return '${api}masters/districts/$districtId/talukas';
  }
  static String getVillages(final int talukaId) {
    return '${api}masters/talukas/$talukaId/villages';
  }
}
