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
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/loader.dart';

class EditDealerProfileController extends GetxController {
  EditDealerProfileController(
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

  final List<String> certificatesPath = <String>[];
  final List<String> existingLicenseDocuments = <String>[];

  String profilePicture = '';

  IdName? selectedState;
  IdName? selectedDistrict;
  IdName? selectedTaluka;
  IdName? selectedVillage;
  DateTime? pesticideLicenseIssueDate;
  DateTime? fertilizerLicenseIssueDate;
  DateTime? seedsLicenseIssueDate;

  bool get hasPesticideLicenseDetails => _hasLicenseDetails(
    txtPesticideLicense,
    txtPesticideLicenseIssueDate,
    txtPesticideLicenseExpireDate,
  );

  bool get hasFertilizerLicenseDetails => _hasLicenseDetails(
    txtFertilizerLicense,
    txtFertilizerLicenseIssueDate,
    txtFertilizerLicenseExpireDate,
  );

  bool get hasSeedsLicenseDetails => _hasLicenseDetails(
    txtSeedsLicense,
    txtSeedsLicenseIssueDate,
    txtSeedsLicenseExpireDate,
  );

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
    if (certificatesPath.isEmpty && existingLicenseDocuments.isEmpty) {
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
        'email': txtEmail.text.trim(),
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
        if (txtReferralName.text.isNotEmpty)
          'referral_person_name': txtReferralName.text.trim(),
        if (txtReferralMobile.text.isNotEmpty)
          'referral_mobile_number': txtReferralMobile.text.trim(),

        if (profilePicture.isNotEmpty &&
            !Utility.checkIsNetworkUrl(profilePicture))
          'profile_photo': await dio.MultipartFile.fromFile(
            profilePicture,
            filename: profilePicture.split(Platform.pathSeparator).last,
          ),
      };

      Loader.load(true);

      final UserProfileModel userProfileModel = await profileRepo
          .completeDealerProfile(params);
      if (userProfileModel.data != null) {
        await commonController.getDealerData();
        Get.back();
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

  void setProfilePic(final String imagePath) {
    profilePicture = imagePath;
    update();
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

  bool _hasLicenseDetails(
    final TextEditingController licenseNumber,
    final TextEditingController issueDate,
    final TextEditingController expireDate,
  ) {
    return licenseNumber.text.trim().isNotEmpty ||
        issueDate.text.trim().isNotEmpty ||
        expireDate.text.trim().isNotEmpty;
  }

  Future<void> _loadLocationData() async {
    await commonController.getStates();
    final Profile? profile = commonController.userProfileModel?.data?.profile;
    if (profile == null) {
      update();
      return;
    }

    txtAgroName.text = profile.shopName ?? '';
    txtDealerName.text = profile.ownerName ?? '';
    txtDetailedAddress.text = profile.address ?? '';
    txtPesticideLicense.text = profile.pesticideLicenseNumber ?? '';
    txtPesticideLicenseIssueDate.text = profile.pesticideLicenseIssueDate ?? '';
    txtPesticideLicenseExpireDate.text =
        profile.pesticideLicenseExpiryDate ?? '';
    txtFertilizerLicense.text = profile.fertilizerLicenseNumber ?? '';
    txtFertilizerLicenseIssueDate.text =
        profile.fertilizerLicenseIssueDate ?? '';
    txtFertilizerLicenseExpireDate.text =
        profile.fertilizerLicenseExpiryDate ?? '';
    txtSeedsLicense.text = profile.seedsLicenseNumber ?? '';
    txtSeedsLicenseIssueDate.text = profile.seedsLicenseIssueDate ?? '';
    txtSeedsLicenseExpireDate.text = profile.seedsLicenseExpiryDate ?? '';
    txtReferralName.text = profile.referralPersonName ?? '';
    txtReferralMobile.text = profile.referralMobile ?? '';
    existingLicenseDocuments
      ..clear()
      ..addAll(
        profile.licenseDocumentUrls ?? profile.licenseDocuments ?? <String>[],
      );

    profilePicture =
        commonController.userProfileModel?.data?.user?.profilePhotoUrl ?? '';

    txtEmail.text = commonController.userProfileModel?.data?.user?.email ?? '';

    pesticideLicenseIssueDate = _parseDate(txtPesticideLicenseIssueDate.text);
    fertilizerLicenseIssueDate = _parseDate(txtFertilizerLicenseIssueDate.text);
    seedsLicenseIssueDate = _parseDate(txtSeedsLicenseIssueDate.text);
    selectedState = _itemById(commonController.states, profile.stateId);
    if (selectedState != null) {
      await commonController.getDistricts(selectedState?.id);
    }
    selectedDistrict = _itemById(
      commonController.districts,
      profile.districtId,
    );
    if (selectedDistrict != null) {
      await commonController.getTalukas(selectedDistrict?.id);
    }
    selectedTaluka = _itemById(commonController.talukas, profile.talukaId);
    if (selectedTaluka != null) {
      await commonController.getVillages(selectedTaluka?.id);
    }
    selectedVillage = _itemById(commonController.villages, profile.villageId);
    update();
  }

  IdName? _itemById(final List<IdName> items, final int? id) {
    if (id == null) return null;
    for (final IdName item in items) {
      if (item.id == id) return item;
    }
    return null;
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
