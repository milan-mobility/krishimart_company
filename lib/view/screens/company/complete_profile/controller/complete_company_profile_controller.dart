import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/network/connection.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/profile_repo.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/loader.dart';

class CompleteCompanyProfileController extends GetxController {
  CompleteCompanyProfileController(this.sharedPref, this.profileRepo);

  final SharedPreferenceHelper sharedPref;
  final ProfileRepo profileRepo;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController txtCompanyName = TextEditingController();
  final TextEditingController txtGstNumber = TextEditingController();
  final TextEditingController txtCinNumber = TextEditingController();
  final TextEditingController txtPanNumber = TextEditingController();
  final TextEditingController txtTanNumber = TextEditingController();
  final TextEditingController txtAddressLine1 = TextEditingController();
  final TextEditingController txtAddressLine2 = TextEditingController();
  final TextEditingController txtState = TextEditingController();
  final TextEditingController txtCity = TextEditingController();
  final TextEditingController txtPincode = TextEditingController();

  String selectedCategory = 'Fertilizer';
  List<String> certificatePaths = <String>[];

  void selectCategory(final String category) {
    selectedCategory = category;
    update();
  }

  Future<void> selectCertificates() async {
    certificatePaths = await Utility.getPhotos();
    update();
  }

  void checkValidation() {
    if (formKey.currentState?.validate() ?? false) {
      saveCompanyProfile();
    }
  }

  Future<void> saveCompanyProfile() async {
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
        'name': txtCompanyName.text.trim(),
        'gst_number': txtGstNumber.text.trim(),
        'cin_number': txtCinNumber.text.trim(),
        'pan_number': txtPanNumber.text.trim(),
        'tan_number': txtTanNumber.text.trim(),
        'business_category': selectedCategory,
        'address_line_1': txtAddressLine1.text.trim(),
        'address_line_2': txtAddressLine2.text.trim(),
        'state': txtState.text.trim(),
        'city': txtCity.text.trim(),
        'pincode': txtPincode.text.trim(),
        'certificates': certificatePaths,
      };

      Loader.load(true);
      await profileRepo.completeFarmerProfile(params);
      Get.offAllNamed(RouteHelper.home);
    } on DioException catch (error) {
      Utility.showAPIError(error);
    } catch (error) {
      debugPrint('EXCEPTION=>${error.toString()}');
    } finally {
      Loader.load(false);
    }
  }

  @override
  void onClose() {
    txtCompanyName.dispose();
    txtGstNumber.dispose();
    txtCinNumber.dispose();
    txtPanNumber.dispose();
    txtTanNumber.dispose();
    txtAddressLine1.dispose();
    txtAddressLine2.dispose();
    txtState.dispose();
    txtCity.dispose();
    txtPincode.dispose();
    super.onClose();
  }
}
