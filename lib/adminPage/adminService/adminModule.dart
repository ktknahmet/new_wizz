import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wizzsales/constants/ApiEndpoints.dart';

class AdminModule{

  baseService(String? token){

    final dio = Dio(BaseOptions(
        contentType:"application/json",
        connectTimeout: const Duration(milliseconds: 30000),
        sendTimeout: const Duration(milliseconds: 30000),
        baseUrl: ApiEndpoints.adminBase,
        headers: {
          "Content-Type": "application/json",
          "Authorization":"Bearer $token",
          "Accept": "application/json",
          "x-api-version":"1.0",
          "x-api-key":"c060c329-d569-4a76-a8ad-c09716c3a764"
        }
    ));
    dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        maxWidth: 300
    ));
    return dio;
  }
}