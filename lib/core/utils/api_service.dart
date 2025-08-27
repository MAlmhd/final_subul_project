import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
// "https://bservice-iq.com/api/login"
// "http://127.0.0.1:8000/api/" =====p=
//"https://bservice-iq.com/api/" last one
  final baseUrl = "https://bservice-iq.com/api/";

  ApiService(this._dio);

  // Future<Map<String, dynamic>> get({required String endPoint}) async {
  //   var response = await _dio.get('$baseUrl$endPoint');
  //   return response.data;
  // }

  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    final response = await _dio.get(
      '$baseUrl$endPoint',
      queryParameters: queryParams,
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    dynamic data,
    Map<String, String>? headers,
  }) async {
    final response = await _dio.post(
      '$baseUrl$endPoint',
      data: data,
      options: Options(headers: headers),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  }) async {
    final response = await _dio.put(
      '$baseUrl$endPoint',
      data: data,
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  }) async {
    final response = await _dio.delete(
      '$baseUrl$endPoint',
      data: data,
      options: Options(headers: headers),
    );
    return response.data;
  }
}
