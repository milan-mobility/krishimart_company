import 'package:dio/dio.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/helpers/extensions/string_ext.dart';
import 'package:krishi_mart/utils/utility.dart';

class DioInterceptor extends InterceptorsWrapper {
  DioInterceptor({
    super.onRequest,
    super.onResponse,
    super.onError,
    required this.sharedPrefHelper,
  });

  final SharedPreferenceHelper sharedPrefHelper;

  @override
  void onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) async {
    String authToken = sharedPrefHelper.authToken;

    if (authToken.isNotNullAndEmpty()) {
      options.headers.putIfAbsent("Accept", () => 'application/json');
      options.headers.putIfAbsent("Content-Type", () => 'application/json');
      options.headers.putIfAbsent("Bearer", () => authToken);
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(final DioException err, final ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if (sharedPrefHelper.isLoggedIn && err.response?.statusCode == 401) {
      Utility.logout();
    }
    Utility.showAPIError(err);
  }
}
