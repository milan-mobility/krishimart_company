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
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/loader.dart';

class EditCompanyProfileController extends GetxController {
  EditCompanyProfileController(
    this.sharedPref,
    this.profileRepo,
    this.commonController,
  );

  final SharedPreferenceHelper sharedPref;
  final ProfileRepo profileRepo;
  final CommonController commonController;

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
  String profilePicture = '';

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
        if (profilePicture.isNotEmpty &&
            !Utility.checkIsNetworkUrl(profilePicture))
          'profile_photo': await dio.MultipartFile.fromFile(
            profilePicture,
            filename: profilePicture.split(Platform.pathSeparator).last,
          ),
      };
      for (int index = 0; index < selectedCategories.length; index++) {
        params['business_category_ids[$index]'] = selectedCategories[index].id;
      }

      Loader.load(true);
      final UserProfileModel userProfileModel = await profileRepo
          .completeCompanyProfile(params);
      if (userProfileModel.data != null) {
        await commonController.getCompanyUserDetail();
        Get.back();
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

  Future<void> _loadOtherData() async {
    await Future.wait<void>(<Future<void>>[
      commonController.getStates(),
      commonController.getCategories(),
    ]);
    await _prefillProfileData();
    update();
  }

  Future<void> _prefillProfileData() async {
    final Profile? profile = commonController.userProfileModel?.data?.profile;
    if (profile == null) {
      return;
    }

    txtCompanyName.text = profile.companyName ?? '';
    txtGstNumber.text = profile.gstNumber ?? '';
    txtCinNumber.text = profile.cinNumber ?? '';
    txtPanNumber.text = profile.panNumber ?? '';
    txtTanNumber.text = profile.tanNumber ?? '';
    txtAddressLine1.text = profile.address ?? '';
    txtAddressLine2.text = profile.addressLine2 ?? '';
    txtPincode.text = profile.postalCode ?? '';
    txtLicenseNumber.text = profile.licenseNumber ?? '';
    txtLicenseIssueDate.text = profile.licenseStartDate ?? '';
    txtLicenseExpireDate.text = profile.licenseEndDate ?? '';

    profilePicture =
        commonController.userProfileModel?.data?.user?.profilePhotoUrl ?? '';

    txtEmail.text = commonController.userProfileModel?.data?.user?.email ?? '';

    selectedState = _itemById(commonController.states, profile.stateId);
    if (selectedState != null) {
      await commonController.getDistricts(selectedState?.id);
    }
    selectedDistrict = _itemById(
      commonController.districts,
      profile.districtId,
    );

    final Set<int> selectedCategoryIds =
        profile.businessCategoryIds?.toSet() ?? <int>{};
    selectedCategories
      ..clear()
      ..addAll(
        commonController.categories.where(
          (final Category category) =>
              selectedCategoryIds.contains(category.id),
        ),
      );
  }

  IdName? _itemById(final List<IdName> items, final int? id) {
    if (id == null) {
      return null;
    }
    for (final IdName item in items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
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

  void setProfilePic(final String imagePath) {
    profilePicture = imagePath;
    update();
  }

  void removeCertificate() {
    profilePicture = '';
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
