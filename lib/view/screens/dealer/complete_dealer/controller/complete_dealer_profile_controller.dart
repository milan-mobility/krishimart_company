import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krishi_mart/data/controllers/common_controller.dart';
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

class CompleteDealerProfileController extends GetxController {
  CompleteDealerProfileController(
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
  final TextEditingController txtAgroName = TextEditingController();
  final TextEditingController txtDealerName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtDetailedAddress = TextEditingController();
  final TextEditingController txtPesticideLicense = TextEditingController();
  final TextEditingController txtPesticideLicenseIssueDate =
      TextEditingController();
  final TextEditingController txtPesticideLicenseExpireDate =
      TextEditingController();
  final TextEditingController txtFertilizerLicense = TextEditingController();
  final TextEditingController txtFertilizerLicenseIssueDate =
      TextEditingController();
  final TextEditingController txtFertilizerLicenseExpireDate =
      TextEditingController();
  final TextEditingController txtSeedsLicense = TextEditingController();
  final TextEditingController txtSeedsLicenseIssueDate =
      TextEditingController();
  final TextEditingController txtSeedsLicenseExpireDate =
      TextEditingController();
  final TextEditingController txtReferralName = TextEditingController();
  final TextEditingController txtReferralMobile = TextEditingController();

  List<String> certificatesPath = [];

  IdName? selectedState;
  IdName? selectedDistrict;
  IdName? selectedTaluka;
  IdName? selectedVillage;
  DateTime? pesticideLicenseIssueDate;
  DateTime? fertilizerLicenseIssueDate;
  DateTime? seedsLicenseIssueDate;
  bool isAutoFillingLocation = false;
  double? latitude;
  double? longitude;

  @override
  void onInit() {
    super.onInit();
    _loadLocationData();
  }

  void checkValidation() {
    final bool hasLocation =
        selectedState != null &&
        selectedDistrict != null &&
        selectedTaluka != null &&
        selectedVillage != null;
    if (!(formKey.currentState?.validate() ?? false) || !hasLocation) {
      showErrorSnackBar(message: 'Please complete all required fields'.tr);
      return;
    }
    if (!_hasAtLeastOneLicense()) {
      showErrorSnackBar(message: 'Please add at least one license detail'.tr);
      return;
    }
    if (certificatesPath.isEmpty) {
      showErrorSnackBar(
        message: 'Please add a certificate for the license details'.tr,
      );
      return;
    }
    if (!_hasValidSeedsLicenseDates()) {
      return;
    }
    saveDealerProfile();
  }

  Future<void> saveDealerProfile() async {
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
        'shop_name': txtAgroName.text.trim(),
        'owner_name': txtDealerName.text.trim(),
        'email': txtEmail.text.trim(),
        'state_id': selectedState?.id,
        'district_id': selectedDistrict?.id,
        'taluka_id': selectedTaluka?.id,
        'village_id': selectedVillage?.id,
        'address': txtDetailedAddress.text.trim(),
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        'pesticide_license_number': txtPesticideLicense.text.trim(),
        'pesticide_license_issue_date': txtPesticideLicenseIssueDate.text
            .trim(),
        'pesticide_license_expiry_date': txtPesticideLicenseExpireDate.text
            .trim(),
        'fertilizer_license_number': txtFertilizerLicense.text.trim(),
        'fertilizer_license_issue_date': txtFertilizerLicenseIssueDate.text
            .trim(),
        'fertilizer_license_expiry_date': txtFertilizerLicenseExpireDate.text
            .trim(),
        'seeds_license_number': txtSeedsLicense.text.trim(),
        'seeds_license_issue_date': txtSeedsLicenseIssueDate.text.trim(),
        'seeds_license_expiry_date': txtSeedsLicenseExpireDate.text.trim(),
        'referral_person_name': txtReferralName.text.trim(),
        'referral_mobile_number': txtReferralMobile.text.trim(),
      };
      for (int index = 0; index < certificatesPath.length; index++) {
        final String certificatePath = certificatesPath[index];
        params['license_documents[$index]'] = await dio.MultipartFile.fromFile(
          certificatePath,
          filename: certificatePath.split(Platform.pathSeparator).last,
        );
      }

      Loader.load(true);

      final UserProfileModel userProfileModel = await profileRepo
          .completeDealerProfile(params);
      if (userProfileModel.data != null) {
        final UserModel? userModel = userProfileModel.data;
        sharedPref.saveHasProfileCompleted(
          userModel?.profileCompleted ?? false,
        );
        await commonController.getDealerData();
        showPrivacyConsentDialog(
          onAccepted: () {
            Get.offAllNamed(RouteHelper.dealerHome);
          },
        );
      }
    } on dio.DioException catch (error) {
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
    selectedTaluka = null;
    selectedVillage = null;
    update();
    await commonController.getDistricts(state?.id);
  }

  Future<void> selectDistrict(final IdName? district) async {
    selectedDistrict = district;
    selectedTaluka = null;
    selectedVillage = null;
    update();
    await commonController.getTalukas(district?.id);
  }

  Future<void> selectTaluka(final IdName? taluka) async {
    selectedTaluka = taluka;
    selectedVillage = null;
    update();
    await commonController.getVillages(taluka?.id);
  }

  void selectVillage(final IdName? village) {
    selectedVillage = village;
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
        txtDetailedAddress.text = location.address;
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
      txtDetailedAddress.text.trim(),
      selectedVillage?.name ?? '',
      selectedTaluka?.name ?? '',
      selectedDistrict?.name ?? '',
      selectedState?.name ?? '',
    ].where((final String value) => value.isNotEmpty).join(', ');
    final location = await locationService.getCoordinatesFromAddress(address);
    if (location != null) {
      latitude = location.latitude;
      longitude = location.longitude;
      return true;
    }

    final bool shouldUseCurrentLocation =
        await CurrentLocationConfirmationDialog.show(profileType: 'Dealer');
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

  void setPesticideLicenseIssueDate(final DateTime date) {
    pesticideLicenseIssueDate = date;
    _setDate(txtPesticideLicenseIssueDate, date);
    update();
  }

  Future<void> selectCertificates() async {
    final List<String> selectedPaths = await Utility.getFile();
    certificatesPath.addAll(selectedPaths);
    update();
  }

  void removeCertificateAt(final int index) {
    certificatesPath.removeAt(index);
    update();
  }

  void setPesticideLicenseExpireDate(final DateTime date) {
    _setDate(txtPesticideLicenseExpireDate, date);
  }

  void setFertilizerLicenseIssueDate(final DateTime date) {
    fertilizerLicenseIssueDate = date;
    _setDate(txtFertilizerLicenseIssueDate, date);
    update();
  }

  void setFertilizerLicenseExpireDate(final DateTime date) {
    _setDate(txtFertilizerLicenseExpireDate, date);
  }

  void setSeedsLicenseIssueDate(final DateTime date) {
    seedsLicenseIssueDate = date;
    _setDate(txtSeedsLicenseIssueDate, date);
    update();
  }

  void setSeedsLicenseExpireDate(final DateTime date) {
    _setDate(txtSeedsLicenseExpireDate, date);
  }

  void _setDate(final TextEditingController controller, final DateTime date) {
    controller.text = DateFormat('yyyy-MM-dd').format(date);
  }

  bool _hasValidSeedsLicenseDates() {
    if (txtSeedsLicense.text.trim().isEmpty) {
      return true;
    }

    final DateTime? issueDate = _parseDate(txtSeedsLicenseIssueDate.text);
    final DateTime? expireDate = _parseDate(txtSeedsLicenseExpireDate.text);
    if (issueDate == null || expireDate == null) {
      showErrorSnackBar(
        message: 'Please add issue and expire dates for the seeds license'.tr,
      );
      return false;
    }
    if (!expireDate.isAfter(issueDate)) {
      showErrorSnackBar(
        message: 'Seeds license expire date must be after the issue date'.tr,
      );
      return false;
    }
    return true;
  }

  bool _hasAtLeastOneLicense() {
    return txtPesticideLicense.text.trim().isNotEmpty ||
        txtFertilizerLicense.text.trim().isNotEmpty ||
        txtSeedsLicense.text.trim().isNotEmpty;
  }

  DateTime? _parseDate(final String value) {
    try {
      return DateFormat('yyyy-MM-dd').parseStrict(value);
    } on FormatException {
      return null;
    }
  }

  Future<void> _loadLocationData() async {
    await commonController.getStates();
  }

  @override
  void onClose() {
    txtAgroName.dispose();
    txtDealerName.dispose();
    txtEmail.dispose();
    txtDetailedAddress.dispose();
    txtPesticideLicense.dispose();
    txtPesticideLicenseIssueDate.dispose();
    txtPesticideLicenseExpireDate.dispose();
    txtFertilizerLicense.dispose();
    txtFertilizerLicenseIssueDate.dispose();
    txtFertilizerLicenseExpireDate.dispose();
    txtSeedsLicense.dispose();
    txtSeedsLicenseIssueDate.dispose();
    txtSeedsLicenseExpireDate.dispose();
    txtReferralName.dispose();
    txtReferralMobile.dispose();
    super.onClose();
  }
}
