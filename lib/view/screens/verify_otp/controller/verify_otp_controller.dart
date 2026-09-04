import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/controllers/common_controller.dart';
import 'package:krishi_mart/data/model/auth_model.dart';
import 'package:krishi_mart/data/model/user_company_module.dart';
import 'package:krishi_mart/data/network/connection.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/auth_repo.dart';
import 'package:krishi_mart/helpers/device_helper.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/app_enums.dart';
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/loader.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class VerifyOtpController extends GetxController {
  VerifyOtpController(this.sharedPref, this.authRepo);

  final SharedPreferenceHelper sharedPref;
  final AuthRepo authRepo;

  String mobile = '';

  final GlobalKey<OtpPinFieldState> otpEmailPinFieldController =
      GlobalKey<OtpPinFieldState>();

  Timer? _timer;
  int start = 0;

  String otpPin = '';

  String get userRole {
    return sharedPref.getUserRole.isNotEmpty
        ? sharedPref.getUserRole
        : UserType.company.name;
  }

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      mobile = Get.arguments['mobile'];
    }
    countDownStart();
  }

  void checkValidation() async {
    if (otpPin.isEmpty) {
      showErrorSnackBar(message: 'Please enter OTP.'.tr);
      return;
    }
    if (otpPin.length < 6) {
      showErrorSnackBar(message: 'Please enter valid OTP.'.tr);
      return;
    }
    verifyOtpApiCall();
  }

  Future<void> verifyOtpApiCall() async {
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
        'mobile': mobile,
        'otp': otpPin,
        'role': userRole,
        'device_name': GetPlatform.isAndroid ? 'android' : 'ios',
        'platform': GetPlatform.isAndroid ? 'android' : 'ios',
        'device_id': await DeviceIdHelper.getDeviceId(),
        'fcm_token': sharedPref.fcmToken,
      };

      Loader.load(true);
      final AuthModel authModel = await authRepo.verifyOTP(params);
      Loader.load(false);

      if (authModel.data != null) {
        UserDetailModel? userModel = authModel.data;

        sharedPref.saveAuthToken(userModel?.accessToken ?? '');
        sharedPref.saveUserInfo(userModel?.user ?? User());
        sharedPref.saveIsLoggedIn(true);
        sharedPref.saveHasProfileCompleted(
          userModel?.hasProfileCompleted ?? false,
        );

        if (userModel?.hasProfileCompleted ?? true) {
          if (sharedPref.getUserRole == UserType.company.name) {
            await Get.find<CommonController>().getCompanyUserDetail();
            Get.offAllNamed(RouteHelper.companyHomeScreen);
          } else {
            await Get.find<CommonController>().getDealerData();
            Get.offAllNamed(RouteHelper.dealerHome);
          }
        } else {
          if (sharedPref.getUserRole == UserType.company.name) {
            Get.offAllNamed(RouteHelper.completeCompanyProfile);
          } else {
            Get.offAllNamed(RouteHelper.completeDealerProfile);
          }
        }
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
    } catch (e) {
      debugPrint('EXCEPTION=>${e.toString()}');
    } finally {
      Loader.load(false);
    }
  }

  Future<void> resendOtpApiCall() async {
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
        'mobile': mobile,
        'role': userRole,
      };

      Loader.load(true);
      final bool response = await authRepo.resendOTP(params);
      Loader.load(false);

      if (response) {
        showSuccessSnackBar(message: 'Otp send successfully'.tr);
        countDownStart();
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

  void countDownStart() {
    start = 60;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (start == 0) {
        timer.cancel();
      } else {
        start--;
        update();
      }
    });
  }

  void clearOtpField() {
    otpPin = '';
    otpEmailPinFieldController.currentState?.clearOtp();
  }

  String get timerText {
    int minutes = start ~/ 60;
    int seconds = start % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void setOTP(final String text) {
    otpPin = text;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
