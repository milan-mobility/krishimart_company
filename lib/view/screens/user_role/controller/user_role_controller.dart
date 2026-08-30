import 'package:get/get.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/app_enums.dart';

class UserRoleController extends GetxController {
  UserRoleController(this.sharedPref);

  final SharedPreferenceHelper sharedPref;

  Future<void> selectRole(final UserType role) async {
    sharedPref.saveRoleSelected(true);
    sharedPref.saveUserRole(role.name);
    Get.toNamed(RouteHelper.login);
  }
}
