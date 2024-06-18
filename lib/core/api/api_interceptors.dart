import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.headers['Content-Type'] = 'application/json';
    // Add any other headers required by your API
    // options.headers['Authorization'] = 'Bearer your_token';
    super.onRequest(options, handler);
  }
}
