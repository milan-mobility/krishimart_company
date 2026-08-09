import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/auth_model.dart';
import 'package:krishi_mart/data/model/id_name_model.dart';
import 'package:krishi_mart/data/network/connection.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/profile_repo.dart';
import 'package:krishi_mart/helpers/extensions/list_extension.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/utils/app_enums.dart';
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/loader.dart';

class CompleteFarmerProfileController extends GetxController {
  CompleteFarmerProfileController(this.sharedPref, this.profileRepo);

  final SharedPreferenceHelper sharedPref;
  final ProfileRepo profileRepo;

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController txtName = TextEditingController();

  List<IdName> districts = [];
  IdName? selectedDistrict;

  List<IdName> talukas = [];
  IdName? selectedTaluka;

  List<IdName> villages = [];
  IdName? selectedVillage;

  List<AppLanguage> languages = AppLanguage.values.toList();

  AppLanguage language = AppLanguage.english;
  String imagePath = '';

  @override
  void onInit() {
    super.onInit();

    getDistricts();
  }

  void checkValidation() {
    if (formKey.currentState?.validate() ?? false) {
      saveUserProfile();
    }
  }

  Future<void> saveUserProfile() async {
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
        'name': txtName.text.trim(),
        'district_id': selectedDistrict?.id ?? 0,
        'taluka_id': selectedTaluka?.id ?? 0,
        'village_id': selectedVillage?.id ?? 0,
        // 'crop_id': '',
        // 'land_area': '',
        // 'soil_type': '',
      };

      Loader.load(true);
      final AuthModel authModel = await profileRepo.completeFarmerProfile(
        params,
      );
      Loader.load(false);

      Get.toNamed(RouteHelper.home);
    } on DioException catch (e) {
      Utility.showAPIError(e);
    } catch (e) {
      debugPrint('EXCEPTION=>${e.toString()}');
    } finally {
      Loader.load(false);
    }
  }

  Future<void> getDistricts() async {
    final bool isInternetAvailable = await ConnectionUtils.isNetworkConnected();
    if (!isInternetAvailable) {
      showErrorSnackBar(
        title: MessageConstant.netWorkTitle,
        message: MessageConstant.networkError,
      );
      return;
    }

    try {
      Loader.load(true);
      final IdNameModel idNameModel = await profileRepo.getDistricts();
      Loader.load(false);

      if (idNameModel.data.isNotNullOrEmpty()) {
        districts = idNameModel.data ?? [];
        update();
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
    } catch (e) {
      debugPrint('EXCEPTION=>${e.toString()}');
    } finally {
      Loader.load(false);
    }
  }

  Future<void> getTalukas(final int id) async {
    final bool isInternetAvailable = await ConnectionUtils.isNetworkConnected();
    if (!isInternetAvailable) {
      showErrorSnackBar(
        title: MessageConstant.netWorkTitle,
        message: MessageConstant.networkError,
      );
      return;
    }

    try {
      Loader.load(true);
      final IdNameModel idNameModel = await profileRepo.getTalukas(id);
      Loader.load(false);

      if (idNameModel.data.isNotNullOrEmpty()) {
        talukas = idNameModel.data ?? [];
      } else {
        talukas = [];
      }
      update();
    } on DioException catch (e) {
      Utility.showAPIError(e);
    } catch (e) {
      debugPrint('EXCEPTION=>${e.toString()}');
    } finally {
      Loader.load(false);
    }
  }

  Future<void> getVillages(final int id) async {
    final bool isInternetAvailable = await ConnectionUtils.isNetworkConnected();
    if (!isInternetAvailable) {
      showErrorSnackBar(
        title: MessageConstant.netWorkTitle,
        message: MessageConstant.networkError,
      );
      return;
    }

    try {
      Loader.load(true);
      final IdNameModel idNameModel = await profileRepo.getVillages(id);
      Loader.load(false);

      if (idNameModel.data.isNotNullOrEmpty()) {
        villages = idNameModel.data ?? [];
      } else {
        villages = [];
      }
      update();
    } on DioException catch (e) {
      Utility.showAPIError(e);
    } catch (e) {
      debugPrint('EXCEPTION=>${e.toString()}');
    } finally {
      Loader.load(false);
    }
  }

  void selectDistrict(final IdName? district) {
    selectedDistrict = district;
    selectedTaluka = null;
    update();
    getTalukas(selectedDistrict?.id ?? 0);
  }

  void selectTaluka(final IdName? taluka) {
    selectedTaluka = taluka;
    selectedVillage = null;
    update();
    getVillages(selectedTaluka?.id ?? 0);
  }

  void selectVillage(final IdName? village) {
    selectedVillage = village;
    update();
  }

  void setLanguage(final AppLanguage appLanguage) {
    language = appLanguage;
    Locale locale = Locale(appLanguage.languageCode);
    sharedPref.setLanguageCode(appLanguage.languageCode);
    Get.updateLocale(locale);
  }

  void setProfilePic(final String imagePath) {
    this.imagePath = imagePath;
    update();
  }
}
