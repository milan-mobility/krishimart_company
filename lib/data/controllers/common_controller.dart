import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/category_model.dart';
import 'package:krishi_mart/data/model/id_name_model.dart';
import 'package:krishi_mart/data/model/user_company_module.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/common_repo.dart';
import 'package:krishi_mart/utils/utility.dart';

class CommonController extends GetxController implements GetxService {
  CommonController(this.sharedPref, this.commonRepo);

  final SharedPreferenceHelper sharedPref;
  final CommonRepo commonRepo;

  List<IdName> states = <IdName>[];
  List<IdName> districts = <IdName>[];
  List<IdName> crops = <IdName>[];
  List<Category> categories = <Category>[];
  int _districtRequestId = 0;
  bool _hasLoadedCrops = false;
  bool _hasLoadedCategories = false;
  Future<void>? _cropsRequest;
  Future<void>? _categoriesRequest;
  UserProfileModel? userProfileModel;

  Future<void> getStates() async {
    if (states.isEmpty) {
      await getStateApiCall();
    }
  }

  Future<void> getStateApiCall() async {
    try {
      final IdNameModel response = await commonRepo.getStates();
      states = response.data ?? <IdName>[];
      update();
    } on DioException catch (error) {
      Utility.showAPIError(error);
    } catch (error) {
      debugPrint('EXCEPTION=>${error.toString()}');
    }
  }

  Future<void> getDistricts(final int? stateId) async {
    final int requestId = ++_districtRequestId;
    districts = <IdName>[];
    update();

    if (stateId == null) {
      return;
    }

    try {
      final IdNameModel response = await commonRepo.getDistricts(stateId);
      if (requestId != _districtRequestId) {
        return;
      }
      districts = response.data ?? <IdName>[];
      update();
    } on DioException catch (error) {
      Utility.showAPIError(error);
    } catch (error) {
      debugPrint('EXCEPTION=>${error.toString()}');
    }
  }

  Future<void> getCrops() {
    if (_hasLoadedCrops) return Future<void>.value();
    return _cropsRequest ??= _getCrops();
  }

  Future<void> _getCrops() async {
    try {
      final IdNameModel response = await commonRepo.getCrops();
      crops = response.data ?? <IdName>[];
      _hasLoadedCrops = true;
      update();
    } on DioException catch (error) {
      Utility.showAPIError(error);
    } catch (error) {
      debugPrint('EXCEPTION=>${error.toString()}');
    } finally {
      _cropsRequest = null;
    }
  }

  Future<void> getCategories() {
    if (_hasLoadedCategories) return Future<void>.value();
    return _categoriesRequest ??= _getCategories();
  }

  Future<void> _getCategories() async {
    try {
      final CategoryModel response = await commonRepo.getCategories();
      categories = response.data ?? <Category>[];
      _hasLoadedCategories = true;
      update();
    } on DioException catch (error) {
      Utility.showAPIError(error);
    } catch (error) {
      debugPrint('EXCEPTION=>${error.toString()}');
    } finally {
      _categoriesRequest = null;
    }
  }

  Future<void> getCompanyUserDetail() async {
    try {
      userProfileModel = await commonRepo.getUserProfile();
      update();
    } on DioException catch (error) {
      Utility.showAPIError(error);
    } catch (error) {
      debugPrint('EXCEPTION=>${error.toString()}');
    }
  }
}
