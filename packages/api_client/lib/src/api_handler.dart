import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:api_client/api_client.dart';

class ApiHandler {
  ApiHandler._();

  loggerInit() {
    Logger.init(
      true, // isEnable ，if production ，please false
      isShowFile: false, // In the IDE, whether the file name is displayed
      isShowTime: false, // In the IDE, whether the time is displayed
      levelDebug: 15,
      levelInfo: 10,
      levelWarn: 5,
      phoneVerbose: Colors.white,
      phoneDebug: const Color(0xff27AE60),
      phoneInfo: const Color(0xff2F80ED),
      phoneWarn: const Color(0xffE2B93B),
      phoneError: const Color(0xffEB5757),
    );
  }

  static final ApiHandler instance = ApiHandler._();

  bool _isInitialized = false;

  late Dio _dio;

  Map<String, dynamic> _basicHeaderPart = {};
  String _token = '';

  updateToken({required String token}) => _token = token;

  void setUp({
    required BaseOptions setupConfiguration,
    required Map<String, dynamic> basicHeaderPart,
    required token,
    required Interceptor interceptor,
  }) {
    loggerInit();
    _dio = Dio(setupConfiguration);
    _basicHeaderPart = basicHeaderPart;
    updateToken(token: token);
    _dio.interceptors.add(interceptor);
    _isInitialized = true;
  }

  Future<Either<ApiFailure, T>> get<T>({
    required String endPoint,
    required T Function(Map<String, dynamic> data) fromData,
    bool withToken = true,
    int expectedStatuscode = 200,
  }) async {
    if (!_isInitialized) {
      throw Exception(
          "Initialization failed. Call setup() before making requests.");
    }

    _dio.options.headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
    }..addAll(!withToken
        ? _basicHeaderPart
        : {HttpHeaders.authorizationHeader: "Bearer $_token"});

    try {
      final response = await _dio.get(
        endPoint,
      );

      Logger.d(response);
      if (response.statusCode != expectedStatuscode) {
        ErrorResponse error = ErrorResponse.fromJson(
          response as Map<String, dynamic>,
        );

        return left(ApiFailure(
          error: error,
          statusCode: response.statusCode ?? -0,
          response: response,
        ));
      } else {
        final regResponse =
            jsonDecode(response.toString()) as Map<String, dynamic>;
        final typedResponse = fromData(regResponse);
        return right(typedResponse);
      }
    } on DioException catch (e) {
      final brokenRes = e.response;
      // print(brokenRes?.data ?? "");
      return left(ApiFailure(
        error: ErrorResponse(
          errors: e.toString(),
        ),
        response: e.response,
        statusCode: brokenRes?.statusCode ?? -0,
      ));
    } catch (e) {
      Logger.e(e);
      return left(ApiFailure(
        error: ErrorResponse(errors: e.toString()),
        statusCode: -1,
      ));
    }
  }

  Future<Either<ApiFailure, T>> post<T>({
    required String endPoint,
    required T Function(Map<String, dynamic> data) fromData,
    bool withToken = true,
    int expectedStatuscode = 201,
    required Map<String, dynamic> body,
  }) async {
    if (!_isInitialized) {
      throw Exception(
          "Initialization failed. Call setup() before making requests.");
    }

    _dio.options.headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
    }..addAll(!withToken
        ? _basicHeaderPart
        : {HttpHeaders.authorizationHeader: "Bearer $_token"});

    try {
      final response = await _dio.post(
        endPoint,
        data: jsonEncode(body),
      );

      // Logger.d(response);
      if (response.statusCode != expectedStatuscode) {
        ErrorResponse error = ErrorResponse.fromJson(
          response.data as Map<String, dynamic>,
        );

        return left(ApiFailure(
          error: error,
          statusCode: response.statusCode ?? -0,
          response: response,
        ));
      } else {
        final regResponse =
            jsonDecode(response.toString()) as Map<String, dynamic>;
        final typedResponse = fromData(regResponse);
        return right(typedResponse);
      }
    } on DioException catch (e) {
      final brokenRes = e.response;
      return left(ApiFailure(
        error: ErrorResponse.fromJson(e.response?.data ?? {}),
        statusCode: brokenRes?.statusCode ?? -0,
        response: e.response,
      ));
    } catch (e) {
      Logger.e(e);
      return left(ApiFailure(
        error: ErrorResponse(errors: e.toString()),
        statusCode: -1,
      ));
    }
  }

  Future<Either<ApiFailure, T>> put<T>({
    required String endPoint,
    required T Function(Map<String, dynamic> data) fromData,
    bool withToken = true,
    int expectedStatuscode = 202,
    required Map<String, dynamic> body,
  }) async {
    if (!_isInitialized) {
      throw Exception(
          "Initialization failed. Call setup() before making requests.");
    }

    _dio.options.headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
    }..addAll(!withToken
        ? _basicHeaderPart
        : {HttpHeaders.authorizationHeader: "Bearer $_token"});

    try {
      final response = await _dio.put(
        endPoint,
        data: jsonEncode(body),
      );

      // Logger.d(response);
      if (response.statusCode != expectedStatuscode) {
        ErrorResponse error = ErrorResponse.fromJson(
          response as Map<String, dynamic>,
        );
        return left(ApiFailure(
          error: error,
          statusCode: response.statusCode ?? -0,
          response: response,
        ));
      } else {
        final regResponse =
            jsonDecode(response.toString()) as Map<String, dynamic>;
        final typedResponse = fromData(regResponse);
        return right(typedResponse);
      }
    } on DioException catch (e) {
      final brokenRes = e.response;
      return left(ApiFailure(
        error: ErrorResponse(errors: e.toString()),
        statusCode: brokenRes?.statusCode ?? -0,
        response: e.response,
      ));
    } catch (e) {
      Logger.e(e);
      return left(ApiFailure(
        error: ErrorResponse(errors: e.toString()),
        statusCode: -1,
      ));
    }
  }

  Future<Either<ApiFailure, T>> delete<T>({
    required String endPoint,
    required T Function(Map<String, dynamic> data) fromData,
    bool withToken = true,
    int expectedStatuscode = 202,
    required Map<String, dynamic> body,
  }) async {
    if (!_isInitialized) {
      throw Exception(
          "Initialization failed. Call setup() before making requests.");
    }

    _dio.options.headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
    }..addAll(!withToken
        ? _basicHeaderPart
        : {HttpHeaders.authorizationHeader: "Bearer $_token"});

    try {
      final response = await _dio.delete(
        endPoint,
        data: jsonEncode(body),
      );

      // Logger.d(response);
      if (response.statusCode != expectedStatuscode) {
        ErrorResponse error = ErrorResponse.fromJson(
          response as Map<String, dynamic>,
        );
        return left(ApiFailure(
          error: error,
          statusCode: response.statusCode ?? -0,
          response: response,
        ));
      } else {
        final regResponse =
            jsonDecode(response.toString()) as Map<String, dynamic>;
        final typedResponse = fromData(regResponse);
        return right(typedResponse);
      }
    } on DioException catch (e) {
      final brokenRes = e.response;
      return left(ApiFailure(
        error: ErrorResponse(errors: e.toString()),
        statusCode: brokenRes?.statusCode ?? -0,
        response: e.response,
      ));
    } catch (e) {
      Logger.e(e);
      return left(ApiFailure(
        error: ErrorResponse(errors: e.toString()),
        statusCode: -1,
      ));
    }
  }
}
