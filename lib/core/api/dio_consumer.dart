import 'package:dio/dio.dart';
import 'package:skinca/core/api/api_consumer.dart';
import 'package:skinca/core/api/api_interceptors.dart';
import 'package:skinca/core/api/end_points.dart';
import 'package:skinca/core/errors/exceptions.dart';


class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        error: true,
    ));
  }
  @override
  Future delete(String path,
      {dynamic data, Map<String, dynamic>? queryParameters,bool isFormData = false  }) async {
    try {
      final response =
          await dio.delete(path, data: isFormData? FormData.fromMap(data): data, queryParameters: queryParameters,);
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await dio.get(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future put(String path,
      {dynamic data, Map<String, dynamic>? queryParameters,bool isFormData = false}) async {
    try {
      final response =
          await dio.patch(path, data: isFormData ? FormData.fromMap(data):data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future post(String path,
      {dynamic data, Map<String, dynamic>? queryParameters,bool isFormData = false }) async {
    try {
      final response =
          await dio.post(path, data: isFormData ? FormData.fromMap(data):data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
  
 
  
  
  }

