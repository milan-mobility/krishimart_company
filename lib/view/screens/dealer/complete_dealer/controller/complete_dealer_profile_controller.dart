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
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/loader.dart';

class CompleteDealerProfileController extends GetxController {
  CompleteDealerProfileController(
    this.sharedPref,
    this.profileRepo,
    this.commonController,
  );

  final SharedPreferenceHelper sharedPref;
  final ProfileRepo profileRepo;
  final CommonController commonController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController txtAgroName = TextEditingController();
  final TextEditingController txtDealerName = TextEditingController();
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

    try {
      final Map<String, dynamic> params = <String, dynamic>{
        '_method': 'PUT',
        'shop_name': txtAgroName.text.trim(),
        'owner_name': txtDealerName.text.trim(),
        'state_id': selectedState?.id,
        'district_id': selectedDistrict?.id,
        'taluka_id': selectedTaluka?.id,
        'village_id': selectedVillage?.id,
        'address': txtDetailedAddress.text.trim(),
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
        Get.offAllNamed(RouteHelper.dealerHome);
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
