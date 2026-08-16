import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:krishi_mart/data/model/common_model.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/data/network/api_end_points.dart';
import 'package:krishi_mart/data/network/dio_client.dart';

class ProductRepo {
  ProductRepo(this._dioClient);

  final DioClient _dioClient;

  Future<CommonModel> createProduct(final Map<String, dynamic> params) async {
    try {
      final Response<dynamic> response = await _dioClient.post(
        Endpoints.createProduct,
        data: FormData.fromMap(params),
      );

      return CommonModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<ProductModel> getProducts(final Map<String, dynamic> params) async {
    try {
      final Response<dynamic> response = await _dioClient.get(
        Endpoints.productList,
        queryParameters: params,
      );

      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> deleteProduct(final int productId) async {
    try {
      final Response<dynamic> response = await _dioClient.delete(
        Endpoints.deleteProduct(productId),
      );

      return response.statusCode == 200 ? true : false;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
