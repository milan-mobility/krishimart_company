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

  IdName? selectedState;
  IdName? selectedDistrict;
  IdName? selectedTaluka;
  IdName? selectedVillage;

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
        'name': txtDealerName.text.trim(),
        'shop_name': txtAgroName.text.trim(),
        'state_id': selectedState?.id,
        'district_id': selectedDistrict?.id,
        'taluka_id': selectedTaluka?.id,
        'village_id': selectedVillage?.id,
        'address': txtDetailedAddress.text.trim(),
        'pesticide_license_number': txtPesticideLicense.text.trim(),
        'pesticide_license_issue_date': txtPesticideLicenseIssueDate.text
            .trim(),
        'pesticide_license_expire_date': txtPesticideLicenseExpireDate.text
            .trim(),
        'fertilizer_license_number': txtFertilizerLicense.text.trim(),
        'fertilizer_license_issue_date': txtFertilizerLicenseIssueDate.text
            .trim(),
        'fertilizer_license_expire_date': txtFertilizerLicenseExpireDate.text
            .trim(),
        'seeds_license_number': txtSeedsLicense.text.trim(),
        'seeds_license_issue_date': txtSeedsLicenseIssueDate.text.trim(),
        'seeds_license_expire_date': txtSeedsLicenseExpireDate.text.trim(),
        'referral_person_name': txtReferralName.text.trim(),
        'referral_mobile_number': txtReferralMobile.text.trim(),
      };

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
    _setDate(txtPesticideLicenseIssueDate, date);
  }

  void setPesticideLicenseExpireDate(final DateTime date) {
    _setDate(txtPesticideLicenseExpireDate, date);
  }

  void setFertilizerLicenseIssueDate(final DateTime date) {
    _setDate(txtFertilizerLicenseIssueDate, date);
  }

  void setFertilizerLicenseExpireDate(final DateTime date) {
    _setDate(txtFertilizerLicenseExpireDate, date);
  }

  void setSeedsLicenseIssueDate(final DateTime date) {
    _setDate(txtSeedsLicenseIssueDate, date);
  }

  void setSeedsLicenseExpireDate(final DateTime date) {
    _setDate(txtSeedsLicenseExpireDate, date);
  }

  void _setDate(final TextEditingController controller, final DateTime date) {
    controller.text = DateFormat('yyyy-MM-dd').format(date);
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
