import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/controllers/common_controller.dart';
import 'package:krishi_mart/data/controllers/loader_controller.dart';
import 'package:krishi_mart/data/network/dio_client.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/services/location_service.dart';
import 'package:krishi_mart/data/repository/auth_repo.dart';
import 'package:krishi_mart/data/repository/common_repo.dart';
import 'package:krishi_mart/data/repository/dashboard_repo.dart';
import 'package:krishi_mart/data/repository/notifications_repo.dart';
import 'package:krishi_mart/data/repository/product_repo.dart';
import 'package:krishi_mart/data/repository/profile_repo.dart';
import 'package:krishi_mart/view/screens/company/home/controller/company_home_controller.dart';
import 'package:krishi_mart/view/screens/dealer/home/controller/dealer_home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  Get.put(sharedPreferences);
  Get.put(SharedPreferenceHelper());
  Get.lazyPut(() => LocationService(), fenix: true);
  final dio = Dio();
  Get.put(dio);

  // ----- HTTP Client -----
  Get.lazyPut(() => DioClient(Get.find<Dio>(), sharedPrefHelper: Get.find()));

  Get.lazyPut(() => CommonRepo(Get.find()), fenix: true);
  Get.lazyPut(() => NotificationsRepo(Get.find()), fenix: true);
  Get.lazyPut(() => ProductRepo(Get.find()), fenix: true);
  Get.lazyPut(() => ProfileRepo(Get.find()), fenix: true);
  Get.lazyPut(() => AuthRepo(Get.find()), fenix: true);
  Get.lazyPut(() => DashboardRepo(Get.find()), fenix: true);

  Get.lazyPut(() => LoaderController());
  Get.lazyPut(() => CommonController(Get.find(), Get.find()));
  Get.lazyPut(() => CompanyHomeController(Get.find(), Get.find()));
  Get.lazyPut(() => DealerHomeController(Get.find(), Get.find()));
}
