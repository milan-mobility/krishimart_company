import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:krishi_mart/data/model/id_name_model.dart';
import 'package:krishi_mart/data/network/api_end_points.dart';
import 'package:krishi_mart/data/network/dio_client.dart';

class CommonRepo {
  CommonRepo(this._dioClient);

  final DioClient _dioClient;

  Future<IdNameModel> getStates() async {
    try {
      final Response<dynamic> response = await _dioClient.get(
        Endpoints.getStates,
      );

      return IdNameModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<IdNameModel> getDistricts(final int stateId) async {
    try {
      final Response<dynamic> response = await _dioClient.get(
        Endpoints.getDistricts(stateId),
      );

      return IdNameModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<IdNameModel> getTalukas(final int districtId) async {
    try {
      final Response<dynamic> response = await _dioClient.get(
        Endpoints.getTalukas(districtId),
      );

      return IdNameModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<IdNameModel> getVillages(final int talukaId) async {
    try {
      final Response<dynamic> response = await _dioClient.get(
        Endpoints.getVillages(talukaId),
      );

      return IdNameModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<IdNameModel> getUserProfile(final int talukaId) async {
    try {
      final Response<dynamic> response = await _dioClient.get(
        Endpoints.getCompanyProfile,
      );

      return IdNameModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
