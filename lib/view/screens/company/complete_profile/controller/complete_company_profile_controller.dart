import 'dart:io';

import 'package:dio/dio.dart' as dio show MultipartFile;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krishi_mart/data/controllers/common_controller.dart';
import 'package:krishi_mart/data/model/category_model.dart';
import 'package:krishi_mart/data/model/id_name_model.dart';
import 'package:krishi_mart/data/model/user_company_module.dart';
import 'package:krishi_mart/data/network/connection.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/profile_repo.dart';
import 'package:krishi_mart/data/services/location_service.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/current_location_confirmation_dialog.dart';
import 'package:krishi_mart/view/base/loader.dart';
import 'package:krishi_mart/view/base/privacy_consent_dialog.dart';

class CompleteCompanyProfileController extends GetxController {
  CompleteCompanyProfileController(
    this.sharedPref,
    this.profileRepo,
    this.commonController,
    this.locationService,
  );

  final SharedPreferenceHelper sharedPref;
  final ProfileRepo profileRepo;
  final CommonController commonController;
  final LocationService locationService;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController txtCompanyName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
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

  final List<Category> selectedCategories = <Category>[];
  String certificatePaths = '';
  bool isAutoFillingLocation = false;
  double? latitude;
  double? longitude;

  @override
  void onInit() {
    super.onInit();
    _loadOtherData();
  }

  void checkValidation() {
    final bool hasLocation = selectedState != null && selectedDistrict != null;
    if (!(formKey.currentState?.validate() ?? false) ||
        !hasLocation ||
        selectedCategories.isEmpty) {
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

    if (!await _ensureCoordinatesForAddress()) {
      return;
    }

    try {
      final Map<String, dynamic> params = <String, dynamic>{
        '_method': 'PUT',
        'company_name': txtCompanyName.text.trim(),
        'email': txtEmail.text.trim(),
        'gst_number': txtGstNumber.text.trim(),
        'cin_number': txtCinNumber.text.trim(),
        'pan_number': txtPanNumber.text.trim(),
        if (txtTanNumber.text.isNotEmpty)
          'tan_number': txtTanNumber.text.trim(),
        'address_line_1': txtAddressLine1.text.trim(),
        'address_line_2': txtAddressLine2.text.trim(),
        'state_id': selectedState?.id,
        'district_id': selectedDistrict?.id,
        'postal_code': txtPincode.text.trim(),
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        'license_number': txtLicenseNumber.text.trim(),
        'license_start_date': txtLicenseIssueDate.text.trim(),
        'license_end_date': txtLicenseExpireDate.text.trim(),
        if (certificatePaths.isNotEmpty)
          'license_certificate': await dio.MultipartFile.fromFile(
            certificatePaths,
            filename: certificatePaths.split(Platform.pathSeparator).last,
          ),
      };
      for (int index = 0; index < selectedCategories.length; index++) {
        params['business_category_ids[$index]'] = selectedCategories[index].id;
      }

      Loader.load(true);
      final UserProfileModel userProfileModel = await profileRepo
          .completeCompanyProfile(params);
      if (userProfileModel.data != null) {
        final UserModel? userModel = userProfileModel.data;
        sharedPref.saveHasProfileCompleted(
          userModel?.profileCompleted ?? false,
        );
        await commonController.getCompanyUserDetail();
        showPrivacyConsentDialog(
          onAccepted: () {
            Get.offAllNamed(RouteHelper.companyHomeScreen);
          },
        );
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

  Future<void> autoFillLocation() async {
    if (isAutoFillingLocation) return;
    isAutoFillingLocation = true;
    update();

    try {
      await commonController.getStates();
      final location = await locationService.getCurrentLocation();
      if (location == null) return;
      latitude = location.latitude;
      longitude = location.longitude;
      if (location.address.isNotEmpty) {
        txtAddressLine1.text = location.address;
      }
      if (location.postalCode.isNotEmpty) {
        txtPincode.text = location.postalCode;
      }

      selectedState = _findLocationItem(
        commonController.states,
        location.state,
      );
      if (selectedState != null) {
        await commonController.getDistricts(selectedState?.id);
        selectedDistrict = _findLocationItem(
          commonController.districts,
          location.district,
        );
      }
    } on LocationServiceException catch (error) {
      showErrorSnackBar(message: error.message.tr);
    } catch (error) {
      debugPrint('Location autofill failed: $error');
      showErrorSnackBar(message: 'Unable to get your current location'.tr);
    } finally {
      isAutoFillingLocation = false;
      update();
    }
  }

  IdName? _findLocationItem(final List<IdName> items, final String name) {
    final String normalizedName = name.trim().toLowerCase();
    if (normalizedName.isEmpty) return null;
    for (final IdName item in items) {
      final String itemName = item.name?.trim().toLowerCase() ?? '';
      if (itemName == normalizedName ||
          itemName.contains(normalizedName) ||
          normalizedName.contains(itemName)) {
        return item;
      }
    }
    return null;
  }

  Future<bool> _ensureCoordinatesForAddress() async {
    if (latitude != null && longitude != null) {
      return true;
    }
    final String address = <String>[
      txtAddressLine1.text.trim(),
      txtAddressLine2.text.trim(),
      selectedDistrict?.name ?? '',
      selectedState?.name ?? '',
      txtPincode.text.trim(),
    ].where((final String value) => value.isNotEmpty).join(', ');
    final location = await locationService.getCoordinatesFromAddress(address);
    if (location != null) {
      latitude = location.latitude;
      longitude = location.longitude;
      return true;
    }

    final bool shouldUseCurrentLocation =
        await CurrentLocationConfirmationDialog.show(profileType: 'Company');
    if (!shouldUseCurrentLocation) return false;
    try {
      final currentLocation = await locationService.getCurrentLocation();
      if (currentLocation == null) return false;
      latitude = currentLocation.latitude;
      longitude = currentLocation.longitude;
      return true;
    } on LocationServiceException catch (error) {
      showErrorSnackBar(message: error.message.tr);
      return false;
    } catch (error) {
      debugPrint('Current location lookup failed: $error');
      showErrorSnackBar(message: 'Unable to get your current location'.tr);
      return false;
    }
  }

  Future<void> _loadOtherData() async {
    await Future.wait<void>(<Future<void>>[
      commonController.getStates(),
      commonController.getCategories(),
    ]);
    update();
  }

  void toggleCategory(final Category category) {
    final int selectedIndex = selectedCategories.indexWhere(
      (final Category item) => item.id == category.id,
    );
    if (selectedIndex >= 0) {
      selectedCategories.removeAt(selectedIndex);
    } else {
      selectedCategories.add(category);
    }
    update();
  }

  bool isCategorySelected(final Category category) {
    return selectedCategories.any(
      (final Category item) => item.id == category.id,
    );
  }

  Future<void> selectCertificates() async {
    final List<String> selectedPaths = await Utility.getFile();
    certificatePaths = selectedPaths.isEmpty ? '' : selectedPaths.first;
    update();
  }

  void removeCertificate() {
    certificatePaths = '';
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
