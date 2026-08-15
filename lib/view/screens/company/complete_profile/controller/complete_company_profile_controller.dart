import 'dart:io';

import 'package:dio/dio.dart' as dio show MultipartFile;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krishi_mart/data/controllers/common_controller.dart';
import 'package:krishi_mart/data/model/id_name_model.dart';
import 'package:krishi_mart/data/model/user_company_module.dart';
import 'package:krishi_mart/data/network/connection.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/profile_repo.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/loader.dart';

class CompleteCompanyProfileController extends GetxController {
  CompleteCompanyProfileController(
    this.sharedPref,
    this.profileRepo,
    this.commonController,
  );

  final SharedPreferenceHelper sharedPref;
  final ProfileRepo profileRepo;
  final CommonController commonController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController txtCompanyName = TextEditingController();
  final TextEditingController txtGstNumber = TextEditingController();
  final TextEditingController txtCinNumber = TextEditingController();
  final TextEditingController txtPanNumber = TextEditingController();
  final TextEditingController txtTanNumber = TextEditingController();
  final TextEditingController txtAddressLine1 = TextEditingController();
  final TextEditingController txtAddressLine2 = TextEditingController();
  final TextEditingController txtPincode = TextEditingController();
  final TextEditingController txtLicenseNumber = TextEditingController();
  final TextEditingController txtLicenseIssueDate = TextEditingController();
  final TextEditingController txtLicenseExpireDate = TextEditingController();

  IdName? selectedState;
  IdName? selectedDistrict;

  String selectedCategory = 'pesticide';
  String certificatePaths = '';

  @override
  void onInit() {
    super.onInit();
    _loadOtherData();
  }

  void checkValidation() {
    // final bool hasLocation = selectedState != null && selectedDistrict != null;
    // final bool hasLicenseCertificate = certificatePaths.isNotEmpty;
    // if (!(formKey.currentState?.validate() ?? false) ||
    //     !hasLocation ||
    //     !hasLicenseCertificate) {
    //   showErrorSnackBar(message: 'Please complete all required fields'.tr);
    //   return;
    // }

    final bool hasLocation = selectedState != null && selectedDistrict != null;
    if (!(formKey.currentState?.validate() ?? false) || !hasLocation) {
      showErrorSnackBar(message: 'Please complete all required fields'.tr);
      return;
    }
    saveCompanyProfile();
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
        '_method': 'PUT',
        'company_name': txtCompanyName.text.trim(),
        'gst_number': txtGstNumber.text.trim(),
        'cin_number': txtCinNumber.text.trim(),
        'pan_number': txtPanNumber.text.trim(),
        'tan_number': txtTanNumber.text.trim(),
        'business_category': selectedCategory,
        'address_line_1': txtAddressLine1.text.trim(),
        'address_line_2': txtAddressLine2.text.trim(),
        'state_id': selectedState?.id,
        'district_id': selectedDistrict?.id,
        'postal_code': txtPincode.text.trim(),
        'license_number': txtLicenseNumber.text.trim(),
        'license_start_date': txtLicenseIssueDate.text.trim(),
        'license_end_date': txtLicenseExpireDate.text.trim(),
        if (certificatePaths.isNotEmpty)
          'license_certificate': await dio.MultipartFile.fromFile(
            certificatePaths,
            filename: certificatePaths.split(Platform.pathSeparator).last,
          ),
      };

      Loader.load(true);
      final UserProfileModel userProfileModel = await profileRepo
          .completeFarmerProfile(params);
      if (userProfileModel.data != null) {
        final UserModel? userModel = userProfileModel.data;
        sharedPref.saveHasProfileCompleted(
          userModel?.profileCompleted ?? false,
        );
        Get.offAllNamed(RouteHelper.companyHomeScreen);
      }
    } on DioException catch (error) {
      Utility.showAPIError(error);
    } catch (error) {
      debugPrint('EXCEPTION=>${error.toString()}');
    } finally {
      Loader.load(false);
    }
  }

  Future<void> selectState(final IdName? state) async {
    selectedState = state;
    selectedDistrict = null;
    update();
    await commonController.getDistricts(state?.id);
  }

  void selectDistrict(final IdName? district) {
    selectedDistrict = district;
    update();
  }

  void _loadOtherData() async {
    await commonController.getStates();
  }

  void selectCategory(final String category) {
    selectedCategory = category;
    update();
  }

  Future<void> selectCertificates() async {
    final List<String> selectedPaths = await Utility.getFile();
    certificatePaths = selectedPaths.isEmpty ? '' : selectedPaths.first;
    update();
  }

  void setLicenseIssueDate(final DateTime date) {
    txtLicenseIssueDate.text = DateFormat('yyyy-MM-dd').format(date);
  }

  void setLicenseExpireDate(final DateTime date) {
    txtLicenseExpireDate.text = DateFormat('yyyy-MM-dd').format(date);
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
    txtPincode.dispose();
    txtLicenseNumber.dispose();
    txtLicenseIssueDate.dispose();
    txtLicenseExpireDate.dispose();
    super.onClose();
  }
}
