import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/dashbord_model.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/dashboard_repo.dart';

class CompanyHomeController extends GetxController implements GetxService {
  CompanyHomeController(this.sharedPref, this.dashboardRepo);

  final SharedPreferenceHelper sharedPref;
  final DashboardRepo dashboardRepo;
  Dashboard? dashboard;
  bool isLoading = false;
  bool hasError = false;

  List<Product> get recentProducts => dashboard?.recentProducts ?? <Product>[];

  int get totalViews =>
      dashboard?.totalViews ??
      recentProducts.fold<int>(
        0,
        (final int total, final Product product) =>
            total + (product.views ?? 0),
      );

  String get companyName =>
      dashboard?.company?.companyName ?? sharedPref.getUserInfo?.name ?? '';

  @override
  void onInit() {
    super.onInit();
    getCompanyDashboard();
  }

  Future<void> getCompanyDashboard() async {
    isLoading = true;
    hasError = false;
    update();

    try {
      final DashboardModel response = await dashboardRepo.getCompanyDashboard(
        sharedPref.getUserRole,
      );
      dashboard = response.data;
    } on DioException {
      hasError = true;
    } catch (_) {
      hasError = true;
    } finally {
      isLoading = false;
      update();
    }
  }
}
