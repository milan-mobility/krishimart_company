import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:krishi_mart/data/model/auth_model.dart';
import 'package:krishi_mart/data/network/api_end_points.dart';
import 'package:krishi_mart/data/network/dio_client.dart';

class AuthRepo {
  AuthRepo(this._dioClient);

  final DioClient _dioClient;

  Future<bool> sendOTP(final Map<String, dynamic> params) async {
    try {
      final Response<dynamic> response = await _dioClient.post(
        Endpoints.sendOTP,
        data: params,
      );

      return response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<AuthModel> verifyOTP(final Map<String, dynamic> params) async {
    try {
      final Response<dynamic> response = await _dioClient.post(
        Endpoints.verifyOTP,
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

  Future<bool> resendOTP(final Map<String, dynamic> params) async {
    try {
      final Response<dynamic> response = await _dioClient.post(
        Endpoints.resendOTP,
        data: params,
      );

      return response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
