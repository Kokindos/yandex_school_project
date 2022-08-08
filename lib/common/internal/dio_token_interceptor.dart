import 'package:dio/dio.dart';

class DioTokenInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers['Authorization']="Bearer Khario";
    handler.next(options);
  }

}
