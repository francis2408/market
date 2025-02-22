import 'package:dio/dio.dart';
import 'package:marketplace/core/constants/api_url.dart';
import 'interceptor.dart';

class ApiClient {
  static final Dio _dio = Dio();

  static Dio get dio => _dio;

  ApiClient._();

  static Future<void> initialize() async {
    _dio.options.baseUrl = ApiUrl.baseUrl;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (options.method == 'POST' || options.method == 'PATCH') {
          options.headers['Content-Type'] = 'application/json';
        }
        if (options.data != null) {
          print("Request Body: ${options.data}");
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError error, handler) {
        return handler.next(error);
      },
    ));

    _dio.interceptors.add(LoggerInterceptor());
  }
}
