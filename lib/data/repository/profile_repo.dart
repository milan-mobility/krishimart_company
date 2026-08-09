import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:krishi_mart/data/model/auth_model.dart';
import 'package:krishi_mart/data/model/id_name_model.dart';
import 'package:krishi_mart/data/network/api_end_points.dart';
import 'package:krishi_mart/data/network/dio_client.dart';

class ProfileRepo {
  ProfileRepo(this._dioClient);

  final DioClient _dioClient;

  Future<IdNameModel> getDistricts() async {
    try {
      final Response<dynamic> response = await _dioClient.get(
        Endpoints.getDistricts,
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

  Future<AuthModel> completeFarmerProfile(
    final Map<String, dynamic> params,
  ) async {
    try {
      final Response<dynamic> response = await _dioClient.post(
        Endpoints.farmerProfile,
        data: params,
      );

      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
