import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final Dio _dio;
  ApiClient(this._dio) {
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
    ));
  }

  Future<Response> postRequest({required String endpoint, Map<String, dynamic>? data, Map<String, dynamic>? query}) async {
    final response = await _dio.post(endpoint, data: data, queryParameters: query);
    return response;
  }

  Future<Response> getRequest({required String endpoint, Map<String, dynamic>? query}) async {
    final response = await _dio.get(endpoint, queryParameters: query);
    return response;
  }
}