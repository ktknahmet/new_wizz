import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wizzsales/constants/ApiEndpoints.dart';

class ServiceModule{

  baseService(String? token,String? profileId,String? salesRoleId){
    final dio = Dio(BaseOptions(
        contentType:"application/json",
        connectTimeout: const Duration(milliseconds: 30000),
        sendTimeout: const Duration(milliseconds: 30000),
        baseUrl: ApiEndpoints.baseUrl,
        headers: {
          'Content-Type': "application/json",
          "Authorization":"Bearer $token",
          "Profile":profileId,
          "Salesroleid":salesRoleId
        }
    ));

    dio.interceptors.add(
        PrettyDioLogger(
        requestBody: true,
        maxWidth: 300,
    ));
    return dio;
  }
}