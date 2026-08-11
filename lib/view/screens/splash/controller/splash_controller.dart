import 'package:get/get.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/app_enums.dart';

class SplashController extends GetxController {
  SplashController(this.sharedPref);

  final SharedPreferenceHelper sharedPref;

  double progress = 0.0;

  @override
  void onInit() {
    super.onInit();
    _startProgress();
  }

  Future<void> _startProgress() async {
    const totalDuration = Duration(seconds: 3);
    const interval = Duration(milliseconds: 30);

    final int steps = totalDuration.inMilliseconds ~/ interval.inMilliseconds;

    for (int i = 0; i <= steps; i++) {
      progress = i / steps;
      update();

      await Future.delayed(interval);
    }

    if (sharedPref.isRoleSelected) {
      if (sharedPref.hasProfileCompleted) {
        if (sharedPref.isLoggedIn) {
          Get.offAllNamed(RouteHelper.home);
        } else {
          Get.offAllNamed(RouteHelper.login);
        }
      } else {
        if (sharedPref.getUserRole == UserType.company.name) {
          Get.offAllNamed(RouteHelper.dealerHome);
        } else {
          Get.offAllNamed(RouteHelper.completeDealerProfile);
        }
      }
    } else {
      Get.offAllNamed(RouteHelper.userRole);
    }
  }
}
