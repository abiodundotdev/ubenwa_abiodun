import 'package:dio/dio.dart';
import 'package:ubenwa/domain/domain.dart';

class DioHttpClient extends AppHttpClient<DioHttpResponse> {
  final Dio dio;
  DioHttpClient(this.dio);

  @override
  Future<DioHttpResponse> get(String url) async {
    final response = await dio.get(url);
    return DioHttpResponse(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  @override
  Future<DioHttpResponse> post(String url, Map<String, dynamic> data) async {
    final response = await dio.post(url, data: data);
    return DioHttpResponse(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  @override
  Future<DioHttpResponse> delete(String url, Map<String, dynamic> data) async {
    final response = await dio.delete(url, data: data);
    return DioHttpResponse(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  @override
  Future<DioHttpResponse> form(String url, FormData formData) async {
    final response = await dio.post(url, data: formData);
    return DioHttpResponse(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }
}

class DioHttpResponse implements AppHttpResponse {
  DioHttpResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
    Map<String, dynamic>? headers,
  });
  @override
  dynamic data;

  @override
  Map? header;

  @override
  int? statusCode;

  @override
  String? statusMessage;
}
