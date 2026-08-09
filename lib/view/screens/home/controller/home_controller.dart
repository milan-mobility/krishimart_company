import 'package:get/get.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';

class HomeController extends GetxController implements GetxService {
  HomeController(this.sharedPref);

  final SharedPreferenceHelper sharedPref;

  @override
  void onInit() {
    super.onInit();
  }
}
