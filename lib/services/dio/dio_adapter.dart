import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:simpliapp/core/core.dart';
import 'package:simpliapp/services/services.dart';

class DioAdapter {
  static Future<Dio> get make async {
    final cont = SC.get;
    final appInfo = await cont.services.appInfo.initialize;
    // String? fcmToken = await FirebaseMessaging.instance.getToken();
    final dio = Dio(
      BaseOptions(
        connectTimeout: AppConstants.requestDuration,
        receiveTimeout: AppConstants.requestDuration,
        sendTimeout: AppConstants.requestDuration,
        baseUrl: Environment.fromConfig.httpBaseUrl,
        headers: <String, dynamic>{
          'DeviceId': appInfo.deviceId,
          'DeviceName': appInfo.deviceName,
          'platform': Platform.operatingSystem,
          'app-version': appInfo.version,
          'fcmtoken': "fcmToken",
          'idempotency-key': "${Random().nextInt(44444)}",
        },
      ),
    )..interceptors.add(
        InterceptorsWrapper(
          onError: _onError,
        ),
      );
    dio.interceptors.add(TokenInterceptor());
    return dio;
  }

  static void _onError(DioException err, ErrorInterceptorHandler handler) {
    final message = err.message;
    final res = err.response;
    final response = DioHttpResponse(
      data: res?.data,
      statusCode: res?.statusCode,
      statusMessage: res?.statusMessage,
    );
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.badCertificate:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeOutException(message: message, response: response);
      case DioExceptionType.badResponse:
        switch (response.statusCode) {
          case HttpStatus.badRequest:
            throw BadRequestException(message: message, response: response);
          case HttpStatus.unauthorized:
            throw UnauthrizedException(message: message, response: response);
          case HttpStatus.notFound:
            throw NotFoundException(message: message, response: response);
          case 403:
            throw DeviceException(message: message, response: response);
          case HttpStatus.unprocessableEntity:
            throw AppException(message: message, response: response);
          case 500:
            throw AppException(message: message, response: response);
          default:
            throw AppException(message: message, response: response);
        }
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw NotInternetException(message: message, response: response);
    }
    return handler.next(err);
  }
}

class TokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["Authorization"] =
        "Bearer ${SC.get.sessionStorage.token.value}";
    super.onRequest(options, handler);
  }
}
