// ignore_for_file: strict_raw_type

import 'dart:developer';

import 'package:api_client/api_client.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // print('REQUEST[${options.method}] => PATH: ${options.path}');
    log('[on Request] -------');
    log('[${options.method}]:[URL : ${options.baseUrl}${options.path}]||[body : ${options.data}]');
    log('[${options.headers}]');
    log('[on Request] -------');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );

    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    log(
      '',
      error:
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path} || ${err.message}',
    );
    super.onError(err, handler);
    // return handler.next(err);
  }
}
