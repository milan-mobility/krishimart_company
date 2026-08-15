import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/id_name_model.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/common_repo.dart';
import 'package:krishi_mart/utils/utility.dart';

class CommonController extends GetxController {
  CommonController(this.sharedPref, this.commonRepo);

  final SharedPreferenceHelper sharedPref;
  final CommonRepo commonRepo;

  List<IdName> states = <IdName>[];
  List<IdName> districts = <IdName>[];
  int _districtRequestId = 0;

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
}
