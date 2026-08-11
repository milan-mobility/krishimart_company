import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/id_name_model.dart';
import 'package:krishi_mart/data/network/connection.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/profile_repo.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/loader.dart';

class CompleteDealerProfileController extends GetxController {
  CompleteDealerProfileController(this.sharedPref, this.profileRepo);

  final SharedPreferenceHelper sharedPref;
  final ProfileRepo profileRepo;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController txtAgroName = TextEditingController();
  final TextEditingController txtDealerName = TextEditingController();
  final TextEditingController txtDetailedAddress = TextEditingController();
  final TextEditingController txtPesticideLicense = TextEditingController();
  final TextEditingController txtFertilizerLicense = TextEditingController();
  final TextEditingController txtSeedsLicense = TextEditingController();
  final TextEditingController txtReferralName = TextEditingController();
  final TextEditingController txtReferralMobile = TextEditingController();

  final List<IdName> states = <IdName>[
    IdName(id: 1, name: 'Gujarat'),
    IdName(id: 2, name: 'Maharashtra'),
    IdName(id: 3, name: 'Rajasthan'),
  ];
  final List<IdName> languages = <IdName>[
    IdName(id: 1, name: 'English', code: 'en'),
    IdName(id: 2, name: 'Gujarati', code: 'gu'),
  ];

  IdName? selectedState;
  IdName? selectedDistrict;
  IdName? selectedTaluka;
  IdName? selectedVillage;
  List<IdName> districts = <IdName>[];
  List<IdName> talukas = <IdName>[];
  List<IdName> villages = <IdName>[];
  IdName? selectedLanguage = IdName(id: 1, name: 'English', code: 'en');

  void selectState(final IdName? state) {
    selectedState = state;
    selectedDistrict = null;
    selectedTaluka = null;
    selectedVillage = null;
    districts = <IdName>[];
    talukas = <IdName>[];
    villages = <IdName>[];
    update();
    getDistricts();
  }

  Future<void> getDistricts() async {
    try {
      final IdNameModel response = await profileRepo.getDistricts();
      districts = response.data ?? <IdName>[];
      update();
    } on DioException catch (error) {
      Utility.showAPIError(error);
    } catch (error) {
      debugPrint('EXCEPTION=>${error.toString()}');
    }
  }

  void selectDistrict(final IdName? district) {
    selectedDistrict = district;
    selectedTaluka = null;
    selectedVillage = null;
    talukas = <IdName>[];
    villages = <IdName>[];
    update();
    if (district?.id != null) getTalukas(district!.id!);
  }

  Future<void> getTalukas(final int districtId) async {
    try {
      final IdNameModel response = await profileRepo.getTalukas(districtId);
      talukas = response.data ?? <IdName>[];
      update();
    } on DioException catch (error) {
      Utility.showAPIError(error);
    } catch (error) {
      debugPrint('EXCEPTION=>${error.toString()}');
    }
  }

  void selectTaluka(final IdName? taluka) {
    selectedTaluka = taluka;
    selectedVillage = null;
    villages = <IdName>[];
    update();
    if (taluka?.id != null) getVillages(taluka!.id!);
  }

  Future<void> getVillages(final int talukaId) async {
    try {
      final IdNameModel response = await profileRepo.getVillages(talukaId);
      villages = response.data ?? <IdName>[];
      update();
    } on DioException catch (error) {
      Utility.showAPIError(error);
    } catch (error) {
      debugPrint('EXCEPTION=>${error.toString()}');
    }
  }

  void selectVillage(final IdName? village) {
    selectedVillage = village;
    update();
  }

  void selectLanguage(final IdName? language) {
    selectedLanguage = language;
    update();
  }

  void saveDraft() {
    Get.snackbar(
      'Draft saved'.tr,
      'Your dealer profile has been saved as a draft'.tr,
    );
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
        'agro_name': txtAgroName.text.trim(),
        'name': txtDealerName.text.trim(),
        'state_id': selectedState?.id,
        'district_id': selectedDistrict?.id,
        'taluka_id': selectedTaluka?.id,
        'village_id': selectedVillage?.id,
        'address': txtDetailedAddress.text.trim(),
        'language': selectedLanguage?.code ?? 'en',
        'pesticide_license_number': txtPesticideLicense.text.trim(),
        'fertilizer_license_number': txtFertilizerLicense.text.trim(),
        'seeds_license_number': txtSeedsLicense.text.trim(),
        'referral_person_name': txtReferralName.text.trim(),
        'referral_mobile_number': txtReferralMobile.text.trim(),
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
    txtAgroName.dispose();
    txtDealerName.dispose();
    txtDetailedAddress.dispose();
    txtPesticideLicense.dispose();
    txtFertilizerLicense.dispose();
    txtSeedsLicense.dispose();
    txtReferralName.dispose();
    txtReferralMobile.dispose();
    super.onClose();
  }
}
