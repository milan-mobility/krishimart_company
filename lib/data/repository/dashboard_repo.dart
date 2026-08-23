import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:krishi_mart/data/model/dashbord_model.dart';
import 'package:krishi_mart/data/model/dealer_banner_model.dart';
import 'package:krishi_mart/data/network/api_end_points.dart';
import 'package:krishi_mart/data/network/dio_client.dart';

class DashboardRepo {
  DashboardRepo(this._dioClient);

  final DioClient _dioClient;

  Future<DashboardModel> getCompanyDashboard(final String role) async {
    try {
      final Response<dynamic> response = await _dioClient.get(
        Endpoints.getDashboard(role),
      );

      return DashboardModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<DealerBannerModel> getBanners(final String role) async {
    try {
      final Response<dynamic> response = await _dioClient.get(
        Endpoints.getBanners(role),
      );

      return DealerBannerModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
