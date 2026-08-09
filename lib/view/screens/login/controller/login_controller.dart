import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/network/connection.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/auth_repo.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/app_enums.dart';
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/loader.dart';

class LoginController extends GetxController {
  LoginController(this.sharedPref, this.authRepo);

  final SharedPreferenceHelper sharedPref;
  final AuthRepo authRepo;

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController txtPhone = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void checkValidation() {
    if (formKey.currentState?.validate() ?? false) {
      sendOTApiCall();
    }
  }

  Future<void> sendOTApiCall() async {
    final bool isInternetAvailable = await ConnectionUtils.isNetworkConnected();
    if (!isInternetAvailable) {
      showErrorSnackBar(
        title: MessageConstant.netWorkTitle,
        message: MessageConstant.networkError,
      );
      return;
    }

    try {
      final Map<String, dynamic> params = <String, dynamic>{
        'mobile': txtPhone.text.trim(),
        'role': UserType.farmer.name,
      };

      Loader.load(true);
      final bool response = await authRepo.sendOTP(params);
      Loader.load(false);

      if (response) {
        Get.toNamed(
          RouteHelper.verifyOtp,
          arguments: {'mobile': txtPhone.text.trim()},
        );
      } else {
        showErrorSnackBar(message: 'Something went Wrong!');
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
    } catch (e) {
      debugPrint('EXCEPTION=>${e.toString()}');
    } finally {
      Loader.load(false);
    }
  }
}
