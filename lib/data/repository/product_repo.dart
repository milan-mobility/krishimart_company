import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/data/network/api_end_points.dart';
import 'package:krishi_mart/data/network/dio_client.dart';
import 'package:krishi_mart/utils/app_enums.dart';

class ProductRepo {
  ProductRepo(this._dioClient);

  final DioClient _dioClient;

  Future<bool> createProduct(
    final Map<String, dynamic> params,
    final String endpoint,
  ) async {
    try {
      final Response<dynamic> response = await _dioClient.post(
        endpoint,
        data: FormData.fromMap(params),
      );

      return response.statusCode == 201 ? true : false;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> updateProduct(
    final Map<String, dynamic> params,
    final String endpoint,
  ) async {
    try {
      final Response<dynamic> response = await _dioClient.post(
        endpoint,
        data: FormData.fromMap(params),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<ProductModel> getProducts(
    final Map<String, dynamic> params,
    final String role,
  ) async {
    try {
      final Response<dynamic> response = await _dioClient.get(
        role == UserType.company.name
            ? Endpoints.productList
            : Endpoints.dealerProductList,
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

  Future<bool> deleteProduct(final int productId, final String role) async {
    try {
      final Response<dynamic> response = await _dioClient.delete(
        role == UserType.company.name
            ? Endpoints.deleteProduct(productId)
            : Endpoints.deleteDealerProduct(productId),
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

  Future<bool> deleteProductImage({
    required final String role,
    required final int productId,
    required final int imageId,
  }) async {
    try {
      final Response<dynamic> response = await _dioClient.delete(
        Endpoints.deleteProductImage(
          role: role,
          productId: productId,
          imageId: imageId,
        ),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> deleteProductReel({required final int productId}) async {
    try {
      final Response<dynamic> response = await _dioClient.delete(
        Endpoints.deleteProductReel(productId: productId),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
